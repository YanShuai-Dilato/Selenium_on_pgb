require 'rspec'
require 'json'
require 'rubygems'
require 'selenium-webdriver'

$:.unshift File.join(File.dirname(__FILE__),"..")

require "action/sign_in_page"
require "action/upload_an_app"
require "tools/new_app_dialog"
require "data/base_env"

describe "Test new an app by zip file" do
    include NewAppDialog
    include BaseEnv

    before(:all) do
        @driver = browser
        @url = base_url + "/people/sign_in"
        @driver.navigate.to @url
        SignInPage.new(@driver).sign_in_with
        wait_for_element_present(":xpath", new_app_btn)
    end

    before(:each) do
        @click_element = UploadAnApp.new(@driver)
    end

    after(:each) do
        @click_element.close_current_browser
    end

    #it "should by zip upload an app successfully" do
    #    @click_element.new_app_with_zip
    #end

    it "should by repo upload an app successfully" do
        @click_element.new_app_with_pub_repo
    end

end