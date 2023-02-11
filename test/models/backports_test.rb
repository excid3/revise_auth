require "test_helper"

class BackportsTest < ActiveSupport::TestCase
  test "authenticate_by" do
    assert User.respond_to?(:authenticate_by)
  end
end
