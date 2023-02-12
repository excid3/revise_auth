require "test_helper"

class BackportsTest < ActiveSupport::TestCase
  test "authenticate_by" do
    assert User.respond_to?(:authenticate_by)
  end

  test "generate_token_for" do
    user = User.new
    assert user.respond_to?(:generate_token_for)
  end

  test "find_by_token_for" do
    assert User.respond_to?(:find_by_token_for)
  end

  test "find_by_token_for!" do
    assert User.respond_to?(:find_by_token_for!)
  end
end
