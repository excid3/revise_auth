describe User, type: :model do
  it "authenticate_by Backport" do
    assert User.respond_to?(:authenticate_by)
  end
end
