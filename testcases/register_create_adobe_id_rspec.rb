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

describe "Register -> create an Adobe ID with provided email" do 
	include RegisterDialog
    include SignInGithubDialog
	include BaseEnv
	include ConfigParam

	before(:all) do 
		init
		@driver = browser
		@register_page = RegisterPage.new @driver
		@base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))

        @user_info = {
			email_address:  "pgbtesttiing.009@g990mail.com",
			password:		"pgbtesting001",
			retype_pass:    "pgbtesting001",
			first_name:		"pgb",
			last_name:		"testing",
			country_region:	"JP"
		}	

        @driver.get path_format_locale("/plans/free-adobeid") 
        sleep 5
        @driver.switch_to.frame(0)
        puts "+ after @driver.switch_to.frame(0)"
        sleep 5
		create_an_adobe_id_btn.click
		puts "+ after create_an_adobe_id_btn.click"
		sleep 5
		puts "+ after before all"
	end

	after(:all) do 
		@driver.quit
	end

	it "With invalid Adobe ID (Email Address)" do
	    user = @user_info.clone
		user[:email_address] = @data_user[$lang][:invalid_user][:id]
		puts "+ #{user}"
		sleep 5
		@warnings = @register_page.enter_register_information(user)
		@warnings.should eql @data_str[$lang][:PGB_enter_a_valid_email]
	end

	it "With unmatched password" do 
	    user = @user_info.clone
		user[:retype_pass] = "something_not_the_original_password"
		puts "+ #{user}"
		@warnings = @register_page.enter_register_information(user)
		sleep 5
		@warnings.should eql @data_str[$lang][:PGB_retyped_password_unmatched]
	end

	it "With invalid First Name" do 
	    user = @user_info.clone
		user[:first_name] = "ſЊџЛ^&*!@##@яѨ҉ҝҾ"
		puts "+ #{user}"
		@warnings = @register_page.enter_register_information(user)
		@warnings.should eql @data_str[$lang][:PGB_first_name_invalid]
	end

	it "With invalid Last Name" do 
	    user = @user_info.clone
		user[:last_name] = "ſЊџЛ^&*!@##@яѨ҉ҝҾ"
		puts "+ #{user}"
		@warnings = @register_page.enter_register_information(user)
		sleep 5
		@warnings.should eql @data_str[$lang][:PGB_last_name_invalid]
	end

	it "Without a country selected" do
	    user = @user_info.clone
		user[:country_region] =""
		puts "+ #{user}"
		@warnings = @register_page.enter_register_information(user)
		sleep 5
		@warnings.should eql @data_str[$lang][:PGB_without_selecting_country]
	end
=begin
	it "create Adobe ID successfully" do 
		@user = @user_info.clone
		@user[:email_address] ="dil45216+test_free_006@adobetest.com"
		@user[:password] = "password"
		@user[:retype_pass] = "password"
		@register_page.enter_register_information(@user_info)
		sleep 5
		@register_page.have_read_and_agree
		sleep 5
		@driver.current_url.should eql @data_url[:sign_in_successfully]
	end
=end
end