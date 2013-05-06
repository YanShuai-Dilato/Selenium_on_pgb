#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative "../tools/register_dialog"
require_relative "../tools/sign_in_github_dialog"
require_relative "../action/register_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"

# This TC describes 
#   situations trying to register with Adobe ID to sign in. 
describe "TC_004: Register -> sign in" do 
	include RegisterDialog
    include SignInGithubDialog
	include BaseEnv
	include ConfigParam
    include WebdriverHelper

	before(:all) do 
        init
		@order_it = WebdriverHelper::Counter.new
        @name_screenshot = "TC_004_IT_"
		@driver = browser
        @driver.manage.window.maximize
		@register_page = RegisterPage.new @driver
		@base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))

        @driver.get path_format_locale("/plans/free-adobeid") 
        @driver.switch_to.frame(0)
        puts "+ after driver.switch_to.frame(0)"
    end

    after(:all) do 
        @register_page.close_current_page
    end

    after(:each) do 
        @name_screenshot += @order_it.inc.to_s

        if example.exception != nil
            # Failure only code goes here
            take_screenshot_with_name @name_screenshot
        end
    end

    context "---- Adobe ID" do 
        it "IT_001: Got an error message with invalid Adobe ID (Email Address)" do 
        	adobe_id_frame_enter_email(@data_user[$lang][:invalid_user][:id])
        	adobe_id_frame_enter_password(@data_user[$lang][:invalid_user][:password])
        	adobe_id_frame_sign_in_btn.click
        	do_not_match_waring.text.should eql @data_str[$lang][:PGB_Adobe_id_and_password_not_match]
        end

        it "IT_002: Got an error message with wrong password" do 
        	adobe_id_frame_enter_email(@data_user[$lang][:invalid_user][:id])
            adobe_id_frame_enter_password(@data_user[$lang][:invalid_user][:password])
        	adobe_id_frame_sign_in_btn.click
        	do_not_match_waring.text.should eql @data_str[$lang][:PGB_Adobe_id_and_password_not_match]
        end

        it "IT_003: Sign in successfully with valid appropriate email and password " do 
        	adobe_id_frame_enter_email(@data_user[$lang][:adobe_id_free_001][:id])
        	adobe_id_frame_enter_password(@data_user[$lang][:adobe_id_free_001][:password])
        	adobe_id_frame_sign_in_btn.click
        	wait_for_page_load(60, @base_url + @data_url[:sign_in_successfully])
        	@driver.current_url.should eql @base_url + @data_url[:sign_in_successfully]
        end
    end
end