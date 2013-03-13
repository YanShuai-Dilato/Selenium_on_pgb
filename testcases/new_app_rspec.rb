# new_app_rspec.rb

require 'rspec'
require 'json'
require 'rubygems'
require 'selenium-webdriver'

require File.dirname(__FILE__) + "\\..\\action\\upload_an_app"
require File.dirname(__FILE__) + "\\..\\tools\\new_app_dialog"
require File.dirname(__FILE__) + "\\..\\action\\sign_in_page"


describe "Test new an app by zip file" do
    include NewAppDialog

    before(:all) do
        @driver = Selenium::WebDriver.for :firefox
        @url = "https://build.phonegap.com/people/sign_in"
        @driver.navigate.to @url
        sleep 3
    end

    before(:each) do
        SignInPage.new(@driver).sign_in_with
        @click_element = UploadAnApp.new(@driver)
    end

    after(:each) do
        close_browser
    end

    it "should upload an app successfully" do
        @click_element.new_app_with_zip
    end
end