#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative "../tools/register_dialog"
require_relative "../tools/sign_in_github_dialog"
require_relative "../tools/new_app_dialog"
require_relative "../tools/anywareContainer"
require_relative "../action/register_page"
require_relative "../action/new_app_page"
require_relative "../action/sign_in_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"

describe "Register -> upgrade plan (Free -> Paid)" do 
	include RegisterDialog
	include NewAppDialog
    include SignInGithubDialog
    include AnywareContainer
	include BaseEnv
	include ConfigParam

	before(:all) do 
		init
		@base_url = base_url
		@data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
	end

	before(:each) do 
		@driver = browser
		@sign_in_page = SignInPage.new @driver
		@driver.get path_format_locale("/people/sign_in")
	end

	after(:each) do 
		@sign_in_page.close_current_browser
	end

	it "with supported area Adobe ID" do 
		@sign_in_page.sign_in_with_adobe_id(
			@data_user[$lang][:adobe_id_for_upgrade_purpose_support_area][:id],
            @data_user[$lang][:adobe_id_for_upgrade_purpose_support_area][:password])
        begin
            sleep 5
        end until @driver.current_url == @base_url + @data_url[:sign_in_successfully]
        puts "current_url -> #{@driver.current_url}"
        puts "data_url[:sign_in_successfully] -> #{@base_url}#{@data_url[:sign_in_successfully]}"

        @new_app_page = NewAppPage.new @driver

        if !@new_app_page.private_app_no?
        	@new_app_page.new_app_with_zip
        	sleep 5
        end

		upgrade_link.click
		sleep 3
		start_at_9_99_btn.click

		if isElementPreset?(:tag_name, "iframe") 
			sleep 5
			@driver.switch_to.frame(0)
			enter_email(@data_user[$lang][:adobe_id_for_upgrade_purpose_support_area][:id])
        	enter_password(@data_user[$lang][:adobe_id_for_upgrade_purpose_support_area][:password])
        	sign_in_btn.click
        	sleep 3
        	@driver.switch_to.default_content
		end
	
		choose_payplan_9_99_link.click
		i_agree_to_the_terms_above.click	
		sleep 30

		fill_Payment_Card	
		fill_Billing_Address
		payment_continue_btn.click
		sleep 35

	end

end