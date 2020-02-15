require 'test_helper'

class NewCkeditorControllerTest < ActionDispatch::IntegrationTest

  test "should open posts new" do
    get '/posts/new'
    assert_response :success
  end

  test "should open users new" do
    get '/users/new'
    assert_response :success
  end

  test "should open projects new" do
    get '/projects/new'
    assert_response :success
  end

end