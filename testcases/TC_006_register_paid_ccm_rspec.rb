#encoding: utf-8

require 'rspec'
require 'rubygems'
require 'selenium-webdriver'
require 'yaml'

require_relative "../tools/register_dialog"
require_relative "../tools/sign_in_github_dialog"
require_relative "../action/register_page"
require_relative "../action/new_app_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"

describe "Register paid CCM account" do 
	include RegisterDialog
    include SignInGithubDialog
	include BaseEnv
	include ConfigParam
	include WebdriverHelper

	before(:all) do 
		init
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
	end

	before(:each) do
		@driver = browser
		@register_page = RegisterPage.new @driver
		@base_url = base_url

		@driver.get path_format_locale("/plans/paid") 
		sleep 5
        @driver.switch_to.frame(0)
        puts "+ after driver.switch_to.frame(0)..."
	end

	after(:each) do
		@driver.quit
	end

	context "Register Paid CCM account and create 2 private apps, with different account" do 
		it "with the first paid ccm account: dil40562+stagedeannual@adobetest.com" do 
			sleep 5
			adobe_id_frame_enter_email(@data_user[$lang][:ccm_acnt_001][:id])
	        adobe_id_frame_enter_password(@data_user[$lang][:ccm_acnt_001][:password])
	        adobe_id_frame_sign_in_btn.click
	        sleep 5
	        @driver.switch_to.default_content
	        puts "+ switch_to.default_content..."
	        wait_for_element_present(:xpath, @data_xpath[:register_page][:ccm_29_99_btn]) 
	        ccm_29_99_btn.click
	        wait_for_page_load("https://creative.adobe.com/plans")
	        @driver.get @base_url
	        sleep 40
	        # try to create 2 private apps 
	        new_app_page = NewAppPage.new @driver
	        app_count_before = new_app_page.get_existing_app_num
            first_app_id_before = new_app_page.get_first_app_id
            puts "+ app_count_before: #{app_count_before}"
            puts "+ first_app_id_before: #{first_app_id_before}"

	        new_app_page.new_private_app_with_repo
	        sleep 30

	        new_app_page.new_private_app_with_repo
	        sleep 30

	        app_count_after = new_app_page.get_existing_app_num
            first_app_id_after = new_app_page.get_first_app_id
            puts "+ app_count_after: #{app_count_after}"
            puts "+ first_app_id_after: #{first_app_id_after}"

            app_count_after.should eql app_count_before + 2
		end

		it "with the second paid ccm account: dil40562+teamfra1128@adobetest.com" do 
			sleep 5
			adobe_id_frame_enter_email(@data_user[$lang][:ccm_acnt_002][:id])
	        adobe_id_frame_enter_password(@data_user[$lang][:ccm_acnt_002][:password])
	        adobe_id_frame_sign_in_btn.click
	        sleep 5
	        @driver.switch_to.default_content
	        puts "+ switch_to.default_content..."
	        wait_for_element_present(:xpath, @data_xpath[:register_page][:ccm_29_99_btn]) 
	        ccm_29_99_btn.click
	        wait_for_page_load("https://creative.adobe.com/plans")
	        @driver.get @base_url
	        sleep 40
	        # try to create 2 private apps 
	        new_app_page = NewAppPage.new @driver
	        app_count_before = new_app_page.get_existing_app_num
            first_app_id_before = new_app_page.get_first_app_id
            puts "+ app_count_before: #{app_count_before}"
            puts "+ first_app_id_before: #{first_app_id_before}"

	        new_app_page.new_private_app_with_repo
	        sleep 30

	        new_app_page.new_private_app_with_repo
	        sleep 30

	        app_count_after = new_app_page.get_existing_app_num
            first_app_id_after = new_app_page.get_first_app_id
            puts "+ app_count_after: #{app_count_after}"
            puts "+ first_app_id_after: #{first_app_id_after}"

            app_count_after.should eql app_count_before + 2
		end

		it "with the third paid ccm account: dil40562+teamfrenuonly1128@adobetest.com" do 
			sleep 5
			adobe_id_frame_enter_email(@data_user[$lang][:ccm_acnt_003][:id])
	        adobe_id_frame_enter_password(@data_user[$lang][:ccm_acnt_003][:password])
	        adobe_id_frame_sign_in_btn.click
	        sleep 5
	        @driver.switch_to.default_content
	        puts "+ switch_to.default_content..."
	        wait_for_element_present(:xpath, @data_xpath[:register_page][:ccm_29_99_btn]) 
	        ccm_29_99_btn.click
	        wait_for_page_load("https://creative.adobe.com/plans")
	        @driver.get @base_url

	        sleep 40
	        # try to create 2 private apps 
	        new_app_page = NewAppPage.new @driver
	        app_count_before = new_app_page.get_existing_app_num
            first_app_id_before = new_app_page.get_first_app_id
            puts "+ app_count_before: #{app_count_before}"
            puts "+ first_app_id_before: #{first_app_id_before}"

	        new_app_page.new_private_app_with_repo
	        sleep 30

	        new_app_page.new_private_app_with_repo
	        sleep 30

	        app_count_after = new_app_page.get_existing_app_num
            first_app_id_after = new_app_page.get_first_app_id
            puts "+ app_count_after: #{app_count_after}"
            puts "+ first_app_id_after: #{first_app_id_after}"

            app_count_after.should eql app_count_before + 2
		end
	end
end