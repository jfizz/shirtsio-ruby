# Shirts.io Ruby Wrapper


TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

`gem 'shirtsio'`

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install shirtsio`


## Usage

TODO: Write usage instructions here


## API Basics

### Authentication

Our API uses an API key authentication system. When you create an account, you will be given a unique API key. Every call you make through the shirts.io API must include this key.

### Errors

    HTTP Status Code Summary
    200 OK - Request successfully delivered.
    400 Bad Request - Parameters invalid.
    401 Unauthorized - API key was invalid or deactivated.
    402 Request Failed - Request failed on server end.
    
### Product Sizes

    xxsml - 2XSmall
    xsml - XSmall
    sml - Small
    med - Medium
    lrg - Large
    xlg - XLarge
    xxl - 2XLarge
    xxxl - 3XLarge
    xxxxl - 4XLarge
    xxxxxl - 5XLarge
    xxxxxxl - 6XLarge

Please see https://www.shirts.io/docs/getting_started/ for the most up-to-date documentation.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
