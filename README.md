# ReviseAuth

[![Gem Version](https://badge.fury.io/rb/revise_auth.svg)](https://badge.fury.io/rb/revise_auth)

A pure Ruby on Rails authentication system like Devise.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "revise_auth"
```

and then run `bundle install`.

Or run this command:

```bash
bundle add "revise_auth"
```

## Usage

### Models

ReviseAuth is designed around a single `User` model. Execute the following to generate the `User` model:

```bash
$ rails g revise_auth:model
```

Optionally, you can add other fields such as `first_name` and `last_name`:

```bash
$ rails g revise_auth:model first_name last_name
```

And then run:

```bash
$ rails db:migrate
```

#### Roles / Other User Types

ReviseAuth only works with a single model to keep things simple. We recommend adding roles to handle other types of users.

You can accomplish this in a few different ways:

* A `roles` attribute on the `User` model
* The Rolify gem

### Routes

The model generator will automatically add ReviseAuth's routes to your router:

```
# config/routes.rb

revise_auth
```

You will want to define a root path. After login (see below), the user will be redirected to the root path.

### Filters and Helpers

To protect your actions from unauthenticated users, you can use the `authenticate_user!` filter:

```ruby
before_action :authenticate_user!
```

In your views, you can use `user_signed_in?` to verify if a user is signed in and `current_user` for using the signed in user.

### Mailer

ReviseAuth will send some emails:

* password reset
* confirmation instructions

Make sure you have the default url options set:

```ruby
# in config/environments/development.rb
config.action_mailer.default_url_options = {host: "localhost", port: 3000}
```

Note: This should be set in all environments.

## Customizing

To customize views, you can run:

```bash
$ rails g revise_auth:views
```

This will copy the views into `app/views/revise_auth` in your application.

### Form Permitted Params

To customize the form parameters, you can add/remove params in `config/initializers/revise_auth.rb`

```ruby
ReviseAuth.configure do |config|
  config.sign_up_params += [:time_zone]
  config.update_params += [:time_zone]
end
```

### After Login Path

After a user logs in they will be redirected to the stashed location or the root path, by default. When a GET request hits `authenticate_user!`, it will stash the request path in the session and redirect back after login.

To override this, define `after_login_path` in your `ApplicationController`. You can also override `ReviseAuthController` and define it there.

```ruby
class ApplicationController < ActionController::Base
  def after_login_path
    root_path
  end
end
```

### Routing Constraints

You can use any of the authentication functionality in your routes using the `ReviseAuth::RouteConstraint` class.

The following will draw routes only if the user is signed in:

```ruby
authenticated ->{ _1.admin? } do
  resource :admin
end

authenticated do
  resource :dashboard
end
```

### Password Length

The minimum acceptable password length for validation defaults to 12 characters but this can be configured in either `config/initializers/revise_auth.rb` or your environment configuration:

```ruby
ReviseAuth.configure do |config|
  config.minimum_password_length = 42
end
```

## Test helpers

ReviseAuth comes with handy helpers you can use in your tests:

```ruby
# POST /login with the given user and password
login(user, password: "password")
# DELETE /logout
logout
```

Include the `ReviseAuth::Test::Helpers` module to make them available in your tests.

```ruby
class ActionDispatch::IntegrationTest
  include ReviseAuth::Test::Helpers
end
```

Then in your tests:

```ruby
class MyControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:bob)
    login @user
  end

  test "..." do
    # ...
  end
end
```

## Contributing

If you have an issue you'd like to submit, please do so using the issue tracker in GitHub. In order for us to help you in the best way possible, please be as detailed as you can.

If you'd like to open a PR please make sure the following things pass:

```bash
bin/rails db:test:prepare
bin/rails test
bundle exec standardrb
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
