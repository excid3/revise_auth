# Example:
describe Api::V1::MesController, type: :controller do
  before :each do
    User.destroy_all
  end

  it "index returns a 401 without creds" do
    get "/api/v1/me"
    assert_equal response.status, 401
    pp response.body
  end

  it "index returns a 401 with bad creds" do
    get "/api/v1/me", as: :json, headers: {Authorization: "Token 123"}
    assert_equal response.status, 401
    pp response.body
  end

  it "index returns a 200 with creds" do
    user = User.new(email: "test@example.org", password: "testtest", password_confirmation: "testtest")
    user.save!
    user.api_tokens.first_or_create(name: ApiToken::APP_NAME)

    get "/api/v1/me", as: :json, headers: {Authorization: user.api_tokens.first.token}
    assert_equal response.status, 200
    pp response.body
  end
end
