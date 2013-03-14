# login_spec.rb

#encoding: utf-8

require 'rspec'
require 'json'
require 'rubygems'
require 'selenium-webdriver'

require File.dirname(__FILE__) + "\/..\/action\/home_page"
require File.dirname(__FILE__) + "\/..\/action\/base_env"

describe "phonegap login" do

    before(:all) do
        @driver = BaseEnv.browser
        @base_url = BaseEnv.base_url
    end

    it "should open the login page" do 
        begin
            @driver.navigate.to @base_url
            @click_element = HomePage.new(@driver)
            @click_element.click_sign_in
            sleep 3
            @driver.current_url.should eql @base_url + "/people/sign_in"
        ensure
            @click_element.close_current_browser
        end
    end
end