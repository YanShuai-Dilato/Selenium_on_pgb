# login_spec.rb

#encoding: utf-8

require 'rspec'
require 'json'
require 'rubygems'
require 'selenium-webdriver'

require File.dirname(__FILE__) + "\\..\\action\\home_page"
require File.dirname(__FILE__) + "\\..\\tools\\home_dialog"

describe "phonegap login" do
    include HomeDialog

    before(:all) do
        @driver = Selenium::WebDriver.for :firefox
        @url = "http://build.phonegap.com"
        @driver.navigate.to @url
    end

    before(:each) do
        @click_element = HomePage.new(@driver)
    end

    it "should open the login page" do 
        begin
            @click_element.click_sign_in
        ensure
            close_browser
        end
    end
end