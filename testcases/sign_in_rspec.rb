# sign_in_rspec.rb

#encoding: utf-8

require 'rspec'
require 'json'
require 'rubygems'
require 'selenium-webdriver'

require File.dirname(__FILE__) + "\\..\\action\\sign_in_page"
require File.dirname(__FILE__) + "\\..\\tools\\sign_in_dialog"

describe "phonegap login with registered valid user" do
    include SignInDialog

    before(:all) do
        @driver = Selenium::WebDriver.for :firefox
        @url = "https://build.phonegap.com/people/sign_in"
        @driver.navigate.to @url
        sleep 3
    end

    before(:each) do
        @click_element = SignInPage.new(@driver)
    end

    it "should login in successfully" do 
        begin
            @click_element.sign_in_with
        ensure
            close_browser
        end
    end
end