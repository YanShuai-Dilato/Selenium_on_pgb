# sign_in_rspec.rb

#encoding: utf-8

require 'rspec'
require 'json'
require 'rubygems'
require 'selenium-webdriver'

require File.dirname(__FILE__) + "\/..\/action\/sign_in_page"
require File.dirname(__FILE__) + "\/..\/action\/base_env"

describe "phonegap login with registered valid user" do
    before(:all) do
        @driver = BaseEnv.browser
        @base_url = BaseEnv.base_url
        @exp_url = JSON.parse(File.read(File.dirname(__FILE__) + "\/..\/data\/data_url.json"))
        wait = Selenium::WebDriver::Wait.new(:timeout => 30)
    end

    before(:each) do
        @driver.navigate.to @base_url
    end

    it "should login in successfully" do 
        begin
            @driver.navigate.to @base_url + "/people/sign_in"
            @click_element = SignInPage.new(@driver)
            @click_element.sign_in_with
            wait.until {driver.current_url == "https://build.phonegap.com/apps" }
            @driver.current_url.should eql @exp_url["sign_in_successfully"]
        ensure
            @click_element.close_current_browser
        end
    end
end