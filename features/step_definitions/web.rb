
Given(/^user is on login page$/) do
  @browser = LoginPage.new
  @browser.load
  @browser.wait_until_login_logo_visible(wait: 20)
  expect(@browser).to have_text('Accepted usernames are:')
  expect(@browser).to have_input_username_field
end

When(/^user enter a valid credential$/) do
  @browser.input_username_field.send_keys(ENV['WEB_USERNAME'])
  @browser.input_password_field.send_keys(ENV['WEB_PASSWORD'])
  @browser.login_button.click
end

Then(/^website home page will have displayed$/) do
  @browser = HomePage.new
  expect(@browser).to have_inventory_item_section
  expect(@browser).to have_cart_container
end
