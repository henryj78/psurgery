require 'test_helper'

class DoorsControllerTest < ActionDispatch::IntegrationTest
  test "should get entrygate" do
    get doors_entrygate_url
    assert_response :success
  end

end
