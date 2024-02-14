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
$ rails g revise_auth:model User first_name last_name
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

Tell your router to add ReviseAuth's controllers:

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

### Views

To customize views, you can run:

```bash
$ rails g revise_auth:views
```

This will copy the views into `app/views/revise_auth` in your application.

### Controllers

If your User model has additional fields and you want to customize your views to allow filling them up during sign up or editing your profile, you need to permit those additional fields.

To do this, define `sign_up_params` and/or `profile_params` in your `ApplicationController` to allow those additional attributes during sign up or profile edit, respectively. You can also override `ReviseAuthController` and define it there.

```ruby
class ApplicationController < ActionController::Base
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name)
  end
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
