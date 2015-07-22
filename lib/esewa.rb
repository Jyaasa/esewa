class Esewa
  attr_accessor :service_code, :product_id, :url, :service_type, :amount, :txtAmt, :total_amount, :service_charge, :delivery_charge,  :success_url, :failure_url
  def initialize(service_code, product_id, service_type = "demo")
    @service_code = service_code
    @product_id = product_id
    @service_type = service_type
  end

  def set_data(amount, txtAmt=0, service_charge=0, delivery_charge=0, success_url='', failure_url='')
    @amount = amount
    @txtAmt = txtAmt
    @service_charge = service_charge
    @delivery_charge = delivery_charge
    @success_url = success_url
    @failure_url = failure_url
  end

  def payment
    calculate_total_amount
    get_url
    response = RestClient.post( @url, tAmt: @total_amount, amt: @amount, txtAmt: @txtAmt, psc: @service_charge, pdc: @delivery_charge, scd: @service_code, pid: @product_id, su: @success_url, fu: @failure_url) do |response, request, result, &block|
      puts response
      if [301, 302, 307].include? response.code
        redirected_url = response.headers[:location]
      else
        response.return!(request, result, &block)
      end
    end
  end

  private
  def get_url
    @url = @service_type.downcase == 'live' ? "https://esewa.com.np/epay/main" : "http://dev.esewa.com.np/epay/main"
  end

  def calculate_total_amount
    @total_amount = @amount + @txtAmt + @service_charge + @delivery_charge
  end
end