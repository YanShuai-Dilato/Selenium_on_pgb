#encoding: utf-8

require 'rspec'
require 'json'
require 'rubygems'
require 'selenium-webdriver'

require "../action/home_page"
require "../data/base_env"

describe "phonegap Home page" do
    include BaseEnv

    before(:all) do
        @driver = browser
        @base_url = base_url
        @click_element = HomePage.new(@driver)
        @data = JSON.parse(File.read("../data/data_xpath.json"))
    end

    before(:each) do
        @driver.get @base_url
    end

    after(:all) do
        @click_element.close_current_browser
    end

    describe "-> Go to the Docs page" do 
        it "should open the Docs page " do 
            @click_element.click_docs_link
            @driver.current_url.should == @base_url + "/docs"
        end
    end

    describe "-> Go to the Blog page" do 
        it "should open the Blog page" do
            @click_element.click_blog_link
            @driver.current_url.should == @base_url + "/blog"
        end
    end

    describe "-> Go to the Support page" do 
        it "should open the Support page" do
            @click_element.click_support_link
            tabs = @driver.window_handles
            @driver.switch_to.window(tabs[1])
            @driver.current_url.should == "http://community.phonegap.com/nitobi/products/nitobi_phonegap_build"
            @driver.switch_to.window(tabs[0])
        end
    end

    describe "-> Go to the Sign In Page" do
        it "should open the sign in page" do    
            @click_element.click_sign_in
            @driver.current_url.should == @base_url + "/people/sign_in"
        end
    end

    describe "-> Go to the Register page" do 
        it "should open the register page" do
            @click_element.click_register
            @driver.current_url.should == @base_url + "/plans"
        end
    end

end