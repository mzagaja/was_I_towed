require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Where is my towed car? | TowedCar.info"
  end

  test "should get towed" do
    get :towed, q: "988SLH"
  end

end