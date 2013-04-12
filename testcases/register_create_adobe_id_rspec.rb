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
		# @base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))

        @user_info = {
			email_address:  "pgbtesting.007@gmail.com",
			password:		"pgbtesting001",
			retype_pass:    "pgbtesting001",
			first_name:		"pgb",
			last_name:		"testing",
			country_region:	"United States"
		}	

        @driver.get path_format_locale("/plans/free-adobeid") 
        sleep 5
		click_create_an_adobe_id_btn
	end

	after(:all) do 
		@register_page.close_current_page
	end

	before(:each) do 
		@register_page.reset_page_content
	end

	it "With invalid Adobe ID (Email Address)" do 
		@user_info[:email_address] = @data_user[:invalid_user][:id]
		@warnings = @register_page.enter_register_information(@user_info)
		@warnings.should eql @data_str[$lang][:PGB_enter_a_valid_email]
	end

	it "With unmatched password" do 
		@user_info[:retype_pass] = "something_not_the_original_password"
		@warnings = @register_page.enter_register_information(@user_info)
		@warnings.should eql @data_str[$leng][:PGB_retyped_password_unmatched]
	end

	it "With invalid First Name" do 
		@user_info[:first_name] = "ſЊџЛяѨ҉ҝҾ"
		@warnings = @register_page.enter_register_information(@user_info)
		@warnings.should eql @data_str[$leng][:PGB_first_name_invalid]
	end

	it "With invalid Last Name" do 
		@user_info[:last_name] = "ſЊџЛяѨ҉ҝҾ"
		@warnings = @register_page.enter_register_information(@user_info)
		@warnings.should eql @data_str[$leng][:PGB_last_name_invalid]
	end
=begin
	it "Without a country selected" do 
		@user_info[:country_region] =""
		@warnings = @register_page.enter_register_information(@user_info)
		@warnings.should eql @data_str[$lang][:PGB_without_selecting_country]
	end

	it "create Adobe ID successfully" do 
		@register_page.enter_register_informater(@user_info)
		sleep 5
		@register_page.have_read_and_agree
		sleep 5
		@driver.current_url.should eql @data_url[:sign_in_successfully]
	end
=end
end