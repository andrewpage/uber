require 'spec_helper'

describe Uber::Client do
  before :each do
    @client = Uber::Client.new('WOBR2u2P1Uajsf67MCf_m_EQ-eRwluKCwRu-o624')

    @start_location = Uber::Location.new(37.646480, -121.871801)
    @end_location = Uber::Location.new(37.637349, -121.891317)
  end

  it 'should get the products' do
    products = @client.products '37', '-122'
    puts products.inspect
  end

  it 'should get accurate price estimates' do
    estimates = @client.estimate_prices(@start_location, @end_location)
    puts estimates.inspect
  end
end