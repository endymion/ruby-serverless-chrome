# require 'httparty'
require 'json'
require 'selenium-webdriver'
require 'base64'

def lambda_handler(event:, context:)
  driver = setup_driver

  # Go to Google.com
  driver.navigate.to 'http://www.google.com'

  # Search for whatever query is specified.
  if event && event['queryStringParameters']['q'] && event['queryStringParameters']['q']
    element = driver.find_element(name: 'q')
    element.send_keys event['queryStringParameters']['q']
    element.submit
  end

  # Take a screenshot.
  screenshot_filename = '/tmp/screenshot.png'
  driver.save_screenshot(screenshot_filename)
  driver.quit

  # Return the screenshot as the HTTP response.
  body = Base64.encode64(File.open(screenshot_filename, 'rb').read)
  {
    statusCode: 200,
    headers: {
      'Content-Type': 'image/png'
    },
    body: body,
    isBase64Encoded: true
  }
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
