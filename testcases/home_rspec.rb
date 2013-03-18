# login_spec.rb

#encoding: utf-8

require 'rspec'
require 'json'
require 'rubygems'
require 'selenium-webdriver'

$:.unshift File.join(File.dirname(__FILE__),"..")

require "action/home_page"
require "data/base_env"

describe "phonegap login" do
    include BaseEnv

    before(:all) do
        @driver = browser
        @base_url = base_url
        @click_element = HomePage.new(@driver)
    end

    after(:each) do
        @click_element.close_current_browser
    end

    it "should open the login page" do 
        @driver.navigate.to @base_url
        @click_element.click_sign_in
        sleep 3
        @driver.current_url.should eql @base_url + "/people/sign_in"
    end
end