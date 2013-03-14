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
        @driver = Selenium::WebDriver.for :chrome
        @url = "https://build.phonegap.com/people/sign_in"
        @driver.navigate.to @url
        SignInPage.new(@driver).sign_in_with
        sleep 3
        # @driver.navigate.to @driver.current_url
        # sleep 2
    end

    before(:each) do
        @click_element = UploadAnApp.new(@driver)
    end

    after(:each) do
        close_browser
    end

    it "should upload an app successfully" do
        @click_element.new_app_with_zip
    end

    def element_present?(how, what)
        @driver.find_element(how, what)
        true
    rescue Selenium::WebDriver::Error::NoSuchElementError
        false
    end
end