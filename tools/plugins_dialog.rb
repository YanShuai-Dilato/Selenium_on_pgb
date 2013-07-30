#encoding: utf-8

require_relative "../lib/webdriver_helper"

module PluginsDialog
    include WebdriverHelper

    define_method :plugin_dialog_get do |str|
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:plugins_page][str]) 
    end

    define_method :highlight_and_return do |field|
        highlight field
        return field
    end
    
end
