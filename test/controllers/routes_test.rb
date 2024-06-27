require "test_helper"

class RoutesTest < ActionDispatch::IntegrationTest
  test "authenticated route constraint" do
    assert_raises ActionController::RoutingError do
      get "/dashboard"
    end

    assert_nothing_raised do
      login users(:bob)
      get "/dashboard"
    end
  end

  test "authenticated admin route constraint" do
    assert_raises ActionController::RoutingError do
      get "/admin"
    end

    assert_raises ActionController::RoutingError do
      login users(:bob)
      get "/admin"
    ensure
      logout
    end

    assert_nothing_raised do
      login users(:admin)
      get "/admin"
    ensure
      logout
    end
  end
end
