require 'test_helper'

class SalePaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sale_payments_index_url
    assert_response :success
  end

  test "should get new" do
    get sale_payments_new_url
    assert_response :success
  end

  test "should get create" do
    get sale_payments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get sale_payments_destroy_url
    assert_response :success
  end

  test "should get update" do
    get sale_payments_update_url
    assert_response :success
  end

  test "should get edit" do
    get sale_payments_edit_url
    assert_response :success
  end

  test "should get show" do
    get sale_payments_show_url
    assert_response :success
  end

end
