$LOAD_PATH.unshift File.expand_path('../../object_abstractions/web', __FILE__)

require "capybara/cucumber"
require "capybara/rspec"
require "selenium-webdriver"
require "dotenv"
require "site_prism"
require "httparty"
require "uri"
require "net/http"
require "nokogiri"
require "open-uri"
require "net/http/post/multipart"
require "logger"
require "uri"
require 'logger'
require 'webdrivers'
require 'json'

Dotenv.load
Dotenv.overload(".env.#{ENV['ENV']}")

# frozen_string_literal: true

# configuration for desktop web
# frozen_string_literal: true

# configuration for desktop and mobile web
browser = (ENV['BROWSER'] || 'chrome').to_sym
wait_time = 60 * 5

puts "Browser   : #{browser}"


Capybara.register_driver :firefox do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  options = Selenium::WebDriver::Firefox::Options.new
  options.add_preference 'dom.webdriver.enabled', false
  options.add_preference 'dom.webnotifications.enabled', false
  options.add_preference 'dom.push.enabled', false
  options.profile = profile
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.open_timeout = wait_time
  client.read_timeout = wait_time
  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    options: options,
    http_client: client
  )
end

Capybara.register_driver :chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-notifications')
  options.add_argument('--window-size=1366,768')
  # handle basic auth
  options.add_argument('--disable-blink-features=BlockCredentialedSubresources')
  options.add_argument('--disable-blink-features=AutomationControlled')
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.open_timeout = wait_time
  client.read_timeout = wait_time
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    http_client: client
  )
end


Capybara.configure do |config|
  config.default_max_wait_time = 20
end


Capybara.default_driver = browser



