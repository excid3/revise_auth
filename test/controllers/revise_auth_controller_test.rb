require "test_helper"

class ReviseAuthControllerTest < ActionDispatch::IntegrationTest
  test "revise_auth_controller?" do
    assert ReviseAuthController.new.revise_auth_controller?
  end

  test "revise_auth_controller for other controllers" do
    refute ::ApplicationController.new.revise_auth_controller?
  end
end
