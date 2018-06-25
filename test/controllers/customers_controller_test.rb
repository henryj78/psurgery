require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get customers_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_url
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post customers_url, params: { customer: { address: @customer.address, boardcertified: @customer.boardcertified, cell_number: @customer.cell_number, city: @customer.city, customer_url: @customer.customer_url, deactivate: @customer.deactivate, description: @customer.description, first_name: @customer.first_name, last_name: @customer.last_name, office_number: @customer.office_number, sale_id: @customer.sale_id, state: @customer.state, state_id: @customer.state_id, status_id: @customer.status_id, validate_cus: @customer.validate_cus, zip: @customer.zip, zone_id: @customer.zone_id } }
    end

    assert_redirected_to customer_url(Customer.last)
  end

  test "should show customer" do
    get customer_url(@customer)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_url(@customer)
    assert_response :success
  end

  test "should update customer" do
    patch customer_url(@customer), params: { customer: { address: @customer.address, boardcertified: @customer.boardcertified, cell_number: @customer.cell_number, city: @customer.city, customer_url: @customer.customer_url, deactivate: @customer.deactivate, description: @customer.description, first_name: @customer.first_name, last_name: @customer.last_name, office_number: @customer.office_number, sale_id: @customer.sale_id, state: @customer.state, state_id: @customer.state_id, status_id: @customer.status_id, validate_cus: @customer.validate_cus, zip: @customer.zip, zone_id: @customer.zone_id } }
    assert_redirected_to customer_url(@customer)
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete customer_url(@customer)
    end

    assert_redirected_to customers_url
  end
end
