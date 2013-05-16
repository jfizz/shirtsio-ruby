require 'cgi'
require 'set'
require 'openssl'
require 'rest_client'
require 'multi_json'

# Version
require "shirtsio/version"

# Resources
require "shirtsio/util"
require "shirtsio/json"
require "shirtsio/shirtsio_object"
require "shirtsio/api_resource"
require "shirtsio/category"
require "shirtsio/product"
require "shirtsio/quote"
require "shirtsio/authentication"
require "shirtsio/webhooks"
require "shirtsio/status"
require "shirtsio/order"

# Error
require "shirtsio/errors/shirtsio_error"
require "shirtsio/errors/api_error"
require "shirtsio/errors/api_connection_error"
require "shirtsio/errors/invalid_request_error"
require "shirtsio/errors/authentication_error"

module Shirtsio
  @api_base = 'https://www.shirts.io/api/v1/'
  #put @api_base

  class << self
    attr_accessor :api_key, :api_base, :api_version
  end

  def self.api_url(url='')
    @api_base + url
  end

  def self.request(method, url, api_key, params={}, headers={})
    unless api_key ||= @api_key
      raise AuthenticationError.new('No API key provided. ' +
                                        'Set your API key using "Shirtsio.api_key = <API-KEY>". ' +
                                        'You can generate API keys from the Shirts.io web interface. ' +
                                        'See https://www.shirts.io for details.')
    end

    if api_key =~ /\s/
      raise AuthenticationError.new('Your API key is invalid, as it contains ' +
                                        'whitespace. (HINT: You can double-check your API key from the ' +
                                        'Shirts.io web interface. See https://www.shirts.io for details.)')
    end

    request_opts = { :verify_ssl => false }

    params = Util.objects_to_ids(params)
    params.update(:api_key => @api_key)
    url = api_url(url)

    case method.to_s.downcase.to_sym
      when :get, :head, :delete
        # Make params into GET parameters
        url += "#{URI.parse(url).query ? '&' : '?'}#{uri_encode(params)}" if params && params.any?
        payload = nil
      else
        #payload = uri_encode(params)
        payload = params
    end

    request_opts.update(:method => method, :open_timeout => 30,
                        :payload => payload, :url => url, :timeout => 80)

    begin
      #puts "in shirtsio.rb"
      #puts request_opts
      response = execute_request(request_opts)
    rescue SocketError => e
      handle_restclient_error(e)
    rescue NoMethodError => e
      # Work around RestClient bug
      if e.message =~ /\WRequestFailed\W/
        e = APIConnectionError.new('Unexpected HTTP response code')
        handle_restclient_error(e)
      else
        raise
      end
    rescue RestClient::ExceptionWithResponse => e
      if rcode = e.http_code and rbody = e.http_body
        handle_api_error(rcode, rbody)
      else
        handle_restclient_error(e)
      end
    rescue RestClient::Exception, Errno::ECONNREFUSED => e
      handle_restclient_error(e)
    end

    [parse(response), api_key]
  end

  private

  def self.user_agent
    @uname ||= get_uname
    lang_version = "#{RUBY_VERSION} p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE})"

    {
        :bindings_version => Shirtsio::VERSION,
        :lang => 'ruby',
        :lang_version => lang_version,
        :platform => RUBY_PLATFORM,
        :publisher => 'shirtsio',
        :uname => @uname
    }

  end

  def self.get_uname
    `uname -a 2>/dev/null`.strip if RUBY_PLATFORM =~ /linux|darwin/i
  rescue Errno::ENOMEM => ex # couldn't create subprocess
    "uname lookup failed"
  end

  def self.uri_encode(params)
    Util.flatten_params(params).
        map { |k,v| "#{k}=#{Util.url_encode(v)}" }.join('&')
  end

  def self.request_headers(api_key)
    headers = {
        :user_agent => "Stripe/v1 RubyBindings/#{Shirtsio::VERSION}",
        :authorization => "Bearer #{api_key}",
        :content_type => 'application/x-www-form-urlencoded'
    }

    headers[:stripe_version] = api_version if api_version

    begin
      headers.update(:x_stripe_client_user_agent => Shirtsio::JSON.dump(user_agent))
    rescue => e
      headers.update(:x_stripe_client_raw_user_agent => user_agent.inspect,
                     :error => "#{e} (#{e.class})")
    end
  end

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end

  def self.parse(response)
    begin
      # Would use :symbolize_names => true, but apparently there is
      # some library out there that makes symbolize_names not work.
      response = Shirtsio::JSON.load(response.body)
    rescue MultiJson::DecodeError
      raise general_api_error(response.code, response.body)
    end

    Util.symbolize_names(response)
  end

  def self.general_api_error(rcode, rbody)
    APIError.new("Invalid response object from API: #{rbody.inspect} " +
                     "(HTTP response code was #{rcode})", rcode, rbody)
  end

  def self.handle_api_error(rcode, rbody)
    begin
      error_obj = Shirtsio::JSON.load(rbody)
      error_obj = Util.symbolize_names(error_obj)
      error = error_obj[:error] or raise Shirtsio.new # escape from parsing

    rescue MultiJson::DecodeError, Shirtsio
      raise general_api_error(rcode, rbody)
    end

    case rcode
      when 400, 404
        raise invalid_request_error error, rcode, rbody, error_obj
      when 401
        raise authentication_error error, rcode, rbody, error_obj
      when 402
        raise card_error error, rcode, rbody, error_obj
      else
        raise api_error error, rcode, rbody, error_obj
    end

  end

  def self.invalid_request_error(error, rcode, rbody, error_obj)
    InvalidRequestError.new(error, nil, rcode,
                            rbody, error_obj)
  end

  def self.authentication_error(error, rcode, rbody, error_obj)
    AuthenticationError.new(error[:message], rcode, rbody, error_obj)
  end

  def self.card_error(error, rcode, rbody, error_obj)
    CardError.new(error[:message], error[:param], error[:code],
                  rcode, rbody, error_obj)
  end

  def self.api_error(error, rcode, rbody, error_obj)
    APIError.new(error[:message], rcode, rbody, error_obj)
  end

  def self.handle_restclient_error(e)
    case e
      when RestClient::ServerBrokeConnection, RestClient::RequestTimeout
        message = "Could not connect to Shirts.io (#{@api_base}). " +
            "Please check your internet connection and try again. "

      when RestClient::SSLCertificateNotVerified
        message = "Could not verify Stripe's SSL certificate. " +
            "Please make sure that your network is not intercepting certificates. "

      when SocketError
        message = "Unexpected error communicating when trying to connect to Stripe. " +
            "You may be seeing this message because your DNS is not working. " +
            "To check, try running 'host www.shirts.io' from the command line."

      else
        message = "Unexpected error communicating with Stripe. " +
            "If this problem persists, let us know at jerry@ooshirts.com."

    end

    raise APIConnectionError.new(message + "\n\n(Network error: #{e.message})")
  end
end