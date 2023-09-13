# ReviseAuth

A pure Ruby on Jets authentication system like Devise.

## Installation

Add this line to your application's Gemfile:

```ruby
bundle add "revise_auth"
```

And then execute the following to generate a `User` model (optionally adding other fields such as `first_name` and `last_name`):
```bash
$ jets g revise_auth:model User first_name last_name
$ jets db:migrate
$ jets g revise_auth:views
```

## Usage

ReviseAuth is designed around a single `User` model.

### Roles / Other User Types

ReviseAuth only works with a single model to keep things simple. We recommend adding roles to handle other types of users.

You can accomplish this in a few different ways:

* A `roles` attribute on the `User` model
* The Rolify gem

