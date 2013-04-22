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

describe "Register -> sign in" do 
	include RegisterDialog
    include SignInGithubDialog
	include BaseEnv
	include ConfigParam
    include WebdriverHelper

	before(:all) do 
		init
		@driver = browser
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

    context "Adobe ID" do 
        it "With invalid Adobe ID (Email Address)" do 
        	adobe_id_frame_enter_email(@data_user[$lang][:invalid_user][:id])
        	adobe_id_frame_enter_password(@data_user[$lang][:invalid_user][:password])
        	adobe_id_frame_sign_in_btn.click
        	do_not_match_waring.should eql @data_str[$lang][:PGB_Adobe_id_and_password_not_match]
        end

        it "With wrong password" do 
        	adobe_id_frame_enter_email(@data_user[$lang][:invalid_user][:id])
            adobe_id_frame_enter_password(@data_user[$lang][:invalid_user][:password])
        	adobe_id_frame_sign_in_btn.click
        	do_not_match_waring.should eql @data_str[$lang][:PGB_Adobe_id_and_password_not_match]
        end

        it "sign in successfully" do 
        	adobe_id_frame_enter_email(@data_user[$lang][:adobe_id_free_001][:id])
        	adobe_id_frame_enter_password(@data_user[$lang][:adobe_id_free_001][:password])
        	adobe_id_frame_sign_in_btn.click
        	wait_for_page_load(60, @base_url + @data_url[:sign_in_successfully])
        	@driver.current_url.should eql @base_url + @data_url[:sign_in_successfully]
        end
    end
end