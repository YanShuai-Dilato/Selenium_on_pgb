# browser_driver.rb

require 'rubygems'
require 'selenium-webdriver'

class BrowserDriver
    @@ie_driver = Selenium::WebDriver.for :ie 
    @@chrome_driver = Selenium::WebDriver.for :chrome 
    @@firefox_driver = Selenium::WebDriver.for :firefox 
end

puts BrowserDriver.firefox_driver