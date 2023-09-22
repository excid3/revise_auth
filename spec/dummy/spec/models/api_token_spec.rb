describe ApiToken, type: :model do
  before :each do
    User.destroy_all
  end

  it "validations" do
    refute ApiToken.new.valid?
  end

  it "creates" do
    user = User.new(email: "test@example.org", password: "testtest", password_confirmation: "testtest")
    user.save!
    assert_equal User.first.email, user.email
    user.api_tokens.first_or_create(name: ApiToken::APP_NAME)
    assert_equal ApiToken.first, user.api_tokens.first
  end
end
