# home_page.rb

require 'json'
require File.dirname(__FILE__) + "\\..\\tools\\home_dialog"

class HomePage
    include HomeDialog

    def initialize(driver)
        @driver = driver
        @data = JSON.parse(File.read("..\\config\\data_xpath.json"))
    end

    def click_sign_in
        sign_in_link.click
    end
    
end