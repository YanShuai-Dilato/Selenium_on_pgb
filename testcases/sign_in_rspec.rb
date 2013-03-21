#encoding: utf-8

require 'rspec'
require 'json'
require 'rubygems'
require 'selenium-webdriver'

require "../action/sign_in_page"
require "../data/base_env"

describe "At build.phonegap.com " do
    include BaseEnv

    before(:all) do
        @driver = browser
        @base_url = base_url
        @data = YAML::load(File.read("../data/data_xpath.yaml"))
        @exp_url = YAML::load(File.read("../data/data_url.yaml"))
        @click_element = SignInPage.new(@driver)
    end

    before(:each) do
        @driver.get @base_url + "/people/sign_in"
    end

    after(:all) do 
        @click_element.close_current_browser
    end

    describe "-> with Adobe ID " do
        it "should sign in successfully" do 
            @click_element.sign_in_with_adobe_id
            @driver.current_url.should == @exp_url["sign_in_successfully"]
        end
    end

    describe "-> with GitHub ID" do
        it "should sign in successfully" do 
            @click_element.sign_in_with_github_id
            @driver.current_url.should == @exp_url["sign_in_successfully"]
        end
    end
=begin
    describe "-> register a new account" do
        it "" do 

        end
    end

    describe "-> I forgot my password" do 
        it "" do 

        end
    end
=end
end