# ReviseAuth

A pure Ruby on Jets authentication system like Devise.

## Installation

Add this line to your application's Gemfile:

```ruby
bundle add "revise_auth-jets"
```

And then execute the following to generate a `User` model (optionally adding other fields such as `first_name` and `last_name`):
```bash
$ jets g revise_auth:model User first_name last_name
$ jets db:migrate
$ jets g revise_auth:views
```

Add ActiveRecord::Base.signed_id_verifier_secret = "custom_verfifier_secret" in your initializers. Set this as an env var


Create your app/mailer/application_mailer.rb

```
class ApplicationMailer < ActionMailer::Base
  default from: 'YOUR_EMAIL@gmail.com'
  layout 'mailer'
end
```


Add your stmp settings in your development.rb
ex:
```
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000, protocol: "https" }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.show_previews = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'gmail.com',
    user_name:            'USERNAME@gmail.com',
    password:             'YOUR_PASS',
    authentication:       'plain'}
```
  To get your stmp pass follow these steps

You need to make a password for specific app

Step one: enable 2FA

https://myaccount.google.com/signinoptions/two-step-verification/enroll-welcome
Step two: create an app-specific password

https://myaccount.google.com/apppasswords

## Usage

ReviseAuth is designed around a single `User` model.

### Roles / Other User Types

ReviseAuth only works with a single model to keep things simple. We recommend adding roles to handle other types of users.

You can accomplish this in a few different ways:

* A `roles` attribute on the `User` model
* The Rolify gem

