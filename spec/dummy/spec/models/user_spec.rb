describe User, type: :model do
  before :each do
    User.destroy_all
  end

  it "validations" do
    refute User.new.valid?
  end

  it "creates" do
    user = User.new(email: "test@example.org", password: "testtest", password_confirmation: "testtest")
    user.save
    assert_equal User.first.email, user.email
  end

  it "does not allow duplicate email" do
    user = User.new(email: "test@example.org", password: "testtest", password_confirmation: "testtest")
    user.save
    user2 = User.new(email: "test@example.org", password: "testtest", password_confirmation: "testtest")
    user2.save
    refute_empty user2.errors.where(:email, :taken)
  end

  it "password required" do
    user = User.new(email: "test@example.org")
    user.save
    refute_empty user.errors.where(:password, :blank)
  end

  it "email is downcased" do
    user = User.new(email: "TEST@example.org")
    user.valid?
    assert_equal "test@example.org", user.email
  end

  it "email is stripped" do
    user = User.new(email: " \tTEST@example.org ")
    user.valid?
    assert_equal "test@example.org", user.email
  end
end
