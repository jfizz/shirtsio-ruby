module Shirtsio
  class Product < APIResource

    @products_url = 'products/'
    @category_url = 'products/category/'

    def Product.list_products(params={})
      category_id = params[:category_id]
      list_products_url = @category_url + category_id + "/"
      response, api_key = Shirtsio.request(:get, list_products_url, @api_key, params={})
      Util.convert_to_shirtsio_object(response, api_key)
      response
    end

    def Product.get_product(params={})
      product_id = params[:product_id]
      get_product_url = @products_url + product_id + "/"
      response, api_key = Shirtsio.request(:get, get_product_url, @api_key, params={})
      Util.convert_to_shirtsio_object(response, api_key)
      response
    end

    def Product.inventory_count(params={})
      product_id = params.delete(:product_id)
      get_product_url = @products_url + product_id + "/"
      response, api_key = Shirtsio.request(:get, get_product_url, @api_key, params)
      #Util.convert_to_shirtsio_object(response, api_key)
      response
    end
  end
end