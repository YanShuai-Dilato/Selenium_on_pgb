$:.unshift File.join(File.dirname(__FILE__),"..")

require 'json'
require "tools/home_dialog"

class HomePage
    include HomeDialog

    def initialize(driver)
        @driver = driver
        @data = JSON.parse(File.read("data/data_xpath.json"))
    end

    def click_sign_in
        sign_in_link.click
    end

    def close_current_browser
        close_browser
    end
end