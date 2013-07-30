#encoding: utf-8

require_relative "../lib/webdriver_helper"

module HeaderDialog
    define_method :header_get do |xpth|
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:header][xpth]) 
    end

    define_method :highlight_and_return do |field|
        highlight field
        return field
    end
end