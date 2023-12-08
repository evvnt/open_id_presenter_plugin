# OpenID COPRL Plugin

A plugin for [COPRL](https://github.com/coprl/coprl) that provides "sign in with" buttons for authenticating users via OpenID.

## Proviers

Currently, the following providers are supported:

* Google
* Facebook

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'open_id_presenter_plugin',  github: 'evvnt/open_id_presenter_plugin', branch: :main, require: false
```

And then execute:

    $ bundle

## Usage

Example POM:

```ruby
# login_form.pom
Coprl::Presenters.define(:login_form) do
  plugin :open_id
  helpers do
    def csrf_token
      token = SecureRandom.hex(32)
      context[:session][:o_csrf_token] = token # retrieve this later server-side
      token
    end
  end

  content do
    google_login google_client_id: :my_google_client_id,
                 scope: %w[openid email profile],
                 redirect_uri: auth_callback_url(:google),
                 o_csrf_token: csrf_token
  end
end

# logins_controller.rb
class LoginsController < ApplicationController
  def auth_callback
    if params[:state] != session[:o_csrf_token]
      raise 'Token mismatch'
    end

    # bring your own HTTP adapter, like HTTParty
    response = HTTParty.post('https://oauth2.googleapis.com/token', body: {
      code: code,
      client_id: :my_google_client_id,
      client_secret: :my_google_client_secret,
      redirect_uri: 'https://example.com/',
      grant_type: 'authorization_code'
    })

    if response.ok?
      token = response['id_token']
      validator = GoogleIDToken::Validator.new

      begin
        user_data = validator.check(token, :my_google_client_id)
        # do something with user_data to log them into your application.
      rescue StandardError => e
        # oh no! let the user know something went wrong.
      end
    end
  end
end
```


Results in the following two buttons:

![A cropped screenshot of two buttons stacked vertically, one displaying "Sign in with Facebook" and the other "Sign in with Google"](./buttons.webp)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/evvnt/open_id_presenter_plugin.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
