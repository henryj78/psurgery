require 'test_helper'

class ZipcodeControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get zipcode_create_url
    assert_response :success
  end

  test "should get customer" do
    get zipcode_customer_url
    assert_response :success
  end

end
