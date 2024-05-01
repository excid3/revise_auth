### Unrelease

### 0.6.0

* Add revise_auth route when generating model #71
* Add configurable password length validation #64

### 0.5.0

* Add czech translation by @JakubSchwar in #44
* remove references to confirmation_token in the model by @kylekeesling in #45
* Add spanish translations. by @patriciomacadden in #53
* Fix email confirmation: ReviseAuth::Model#confirm_email_change now clears the unconfirmed email. by @patriciomacadden in #55
* Fix password reset form by @patriciomacadden in #57
* Add configurable form params by @excid3 in #61
* I18n: translate all strings and add i18n-tasks. by @patriciomacadden in #58

### 0.4.1

* Add `RouteConstraint` examples to README and tests

### 0.4.0

* [Breaking] Require Rails 7.1 and higher
* Add reset password functionality @kylekeesling
* Use `password_challenge` for update password @kylekeesling

### 0.3.0

* Create zh-TW.yml for translate traditional chinese by @RobertChang0722 in https://github.com/excid3/revise_auth/pull/8
* Add french translations by @JulienItard in https://github.com/excid3/revise_auth/pull/7
* Add german translation by @drale2k in https://github.com/excid3/revise_auth/pull/11
* Add turkish translations by @beyzaakyol in https://github.com/excid3/revise_auth/pull/12
* Added dutch language support by @yorickvandervis in https://github.com/excid3/revise_auth/pull/9
* Add greek translation by @stefanos450 in https://github.com/excid3/revise_auth/pull/17
* Add model generator by @gathuku in https://github.com/excid3/revise_auth/pull/4
* Prevent session fixation attack by @gathuku in https://github.com/excid3/revise_auth/pull/24

### 0.2.0

* Adds `authenticated` and `unauthenticated` route helpers
* Minimum password length of 12
* Add `revise_auth_controller?` helper to check if controller is from revise_auth

### 0.1.1

* Fixed render not finding view when updating password
* Update translations

### 0.1.0

* Initial release
