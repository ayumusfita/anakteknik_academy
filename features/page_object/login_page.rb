# frozen_string_literal: true

class LoginPage < SitePrism::Page
  path = ENV['WEB_BASE_URL'] + '/'
  set_url(path)

  element :login_logo, '.login_logo'
  element :input_username_field, '#user-name'
  element :input_password_field, '#password'
  element :login_button, '#login-button'
end
