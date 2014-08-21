module Uber
  class Client
    attr_reader :token, :options

    def initialize(token, options = {})
      @token = token
      @options = DEFAULT_OPTIONS.merge(options)
    end

    ##
    # Gets a list of all available Uber products near current coordinates.
    ##
    def products(latitude, longitude)
      result = get('products', { latitude: latitude, longitude: longitude })['products']
      products = []

      for hash in result
        products << Product.new(hash)
      end

      products
    end

    ##
    # Estimates the price for a ride between one location and the other
    ##
    def estimate_prices(start, destination, product = nil)
      params = {
        start_latitude: start.latitude,
        start_longitude: start.longitude,
        end_latitude: destination.latitude,
        end_longitude: destination.longitude
      }

      result = get('estimates/price', params)['prices']
      prices = []

      for hash in result
        prices << Uber::Price.new(hash) if product && (product.display_name == price.display_name)
      end

      prices
    end

    ##
    # Estimates the time until Uber arrives
    ##
    def estimate_time(start, product)
      params = {
          start_latitude: start.latitude,
          start_longitude: start.longitude,
          product_id: product.product_id
      }

      result = get('estimates/time', params)['times']
      times = []

      for hash in result
        times << Uber::Time.new(hash)
      end

      times
    end

    private
    ##
    # Get request to the Uber API
    ##
    def get(url, params={})
      url = '/' + url if url[0] != '/'
      url = Uber::BASE_URL + url
      unless params.keys.empty?
        url = url + '?' + hash_to_query(params)
      end

      result = RestClient.get url, {"Authorization" => "Token #{token}"}
      JSON.parse(result)
    end

    ##
    # Post request to the Uber API
    ##
    def post(url, params={})
      url = '/' + url if url[0] != '/'
      url = Uber::BASE_URL + url
      result = RestClient.post url, params, {"Authorization" => "Token #{token}"}
      JSON.parse(result)
    end

    ##
    # Generates a URL query string ("?x=5&y=6&z=7") from a hash
    ##
    def hash_to_query(hash)
      URI.encode(hash.map{|k,v| "#{k}=#{v}"}.join("&"))
    end

    ##
    # Default Options
    ##
    DEFAULT_OPTIONS = { }
  end
end