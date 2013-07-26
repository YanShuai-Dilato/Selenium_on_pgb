#encoding: utf-8

module PluginsDialog
    # require_relative "../lib/webdriver_helper"

    # include WebdriverHelper

    define_method :get do |str|
        @driver.find_element(:xpath => @data_xpath[:plugins_page][str]) 
    end
    
end
