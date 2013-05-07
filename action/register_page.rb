#encoding: utf-8

require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"
require_relative "../tools/register_dialog"

class RegisterPage
	include ConfigParam
	include WebdriverHelper
	include RegisterDialog

	def initialize(driver)
		puts "+ <action> initialize RegisterPage --- begin"
		@driver = driver
		@base_url = base_url
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		puts "+ <action> initialize RegisterPage --- end"
	end

	# Fill in the register form by providing a array which contains 
	# user-related informations like: email address, password, first name, last name, and coutry-region. 
	# methods: "adobe_id_frame_*" were defined in register_dialog.rb located in "tools/"
	def enter_register_information(user) 
		puts "+ <action> enter_register_information --- begin"
		adobe_id_frame_enter_username(user[:email_address])
		adobe_id_frame_enter_password_2(user[:password])
		adobe_id_frame_retype_password(user[:retype_pass])
		adobe_id_frame_firstname_input(user[:first_name])
		adobe_id_frame_lastname_input(user[:last_name])
		adobe_id_select_country_region(user[:country_region])

		create_btn.click
		sleep 5
		puts "+ <action> enter_register_information --- end"

		if warning_display? 
			return adobe_id_frame_warning_message.text
		end

	end

	# Just help to click the 'Accept' btn. 
	def have_read_and_agree
		puts "+ <action> have_read_and_agree --- begin"
		read_and_agree_the_term_checkbox.click
		accept_btn.click
		puts "+ <action> have_read_and_agree --- end"
	end

	# There are warnings
	# This helper tool helps to detect if warning message appears. 
    def warning_display?
        begin
        	@driver.find_element(:xpath, @data_xpath[:register_page][:adobe_id_frame_warning_message])
        	true
    	rescue Selenium::WebDriver::Error::NoSuchElementError
        	false
    	end
    end
end