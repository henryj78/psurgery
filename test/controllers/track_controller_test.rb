require 'test_helper'

class TrackControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get track_index_url
    assert_response :success
  end

end
