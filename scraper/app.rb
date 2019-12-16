# require 'httparty'
require 'json'
require 'selenium-webdriver'

def lambda_handler(event:, context:)
  driver = setup_driver
  driver.navigate.to 'http://www.google.com'
  element = driver.find_element(name: 'q')
  element.send_keys 'Pizza'
  element.submit
  title = driver.title
  driver.quit
  { statusCode: 200, body: JSON.generate(title) }
end

def setup_driver
  service = Selenium::WebDriver::Service.chrome(path: 'bin/chromedriver')
  Selenium::WebDriver.for :chrome, service: service, options: driver_options
end

def driver_options
  options = Selenium::WebDriver::Chrome::Options.new(binary: 'bin/headless-chromium')
  arguments = %w[--headless --disable-gpu --window-size=1280x1696
                 --disable-application-cache --disable-infobars --no-sandbox
                 --hide-scrollbars --enable-logging --log-level=0
                 --single-process --ignore-certificate-errors --homedir=/tmp]
  arguments.each do |argument|
    options.add_argument(argument)
  end
  options
end
