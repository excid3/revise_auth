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
$ rails g revise_auth:model first_name last_name
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
