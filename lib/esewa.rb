# require 'rest-client'
module Esewa
  class Base
    attr_accessor :service_code, :product_id
    def initialize(service_code, product_id)
      @service_code = service_code
      @product_id = product_id
    end
  end
end

require 'esewa/payment'
