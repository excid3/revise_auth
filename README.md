# ReviseAuth

[![Gem Version](https://badge.fury.io/rb/revise_auth.svg)](https://badge.fury.io/rb/revise_auth)

A pure Ruby on Rails authentication system like Devise.

## Installation

Add this line to your application's Gemfile:

```ruby
bundle add "revise_auth"
```

And then execute the following to generate a `User` model (optionally adding other fields such as `first_name` and `last_name`):
```bash
$ rails g revise_auth:model User first_name last_name
$ rails db:migrate
```

## Usage

ReviseAuth is designed around a single `User` model.

### Roles / Other User Types

ReviseAuth only works with a single model to keep things simple. We recommend adding roles to handle other types of users.

You can accomplish this in a few different ways:

* A `roles` attribute on the `User` model
* The Rolify gem

## Customizing

To customize views, you can run:

```bash
$ rails g revise_auth:views
```

This will copy the views into `app/views/revise_auth` in your application.

### After Login Path

After a user logs in they will be redirected to the stashed location or the root path, by default. When a GET request hits `authenticate_user!`, it will stash the request path in the session and redirect back after login.

To override this, define `after_login_path` in your ApplicationController. You can also override `ReviseAuthController` and define it there.

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
constraints ->(request) { ReviseAuth::RouteConstraint.new(request).current_user&.admin? } do
  resource :admin
end

constraints ->(request) { ReviseAuth::RouteConstraint.new(request).user_signed_in? } do
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
