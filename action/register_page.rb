#encoding: utf-8

require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"
require_relative "../tools/register_dialog"

class RegisterPage
	include ConfigParam
	include WebdriverHelper
	include RegisterDialog

	def initialize(driver)
		@driver = driver
		@base_url = base_url
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
	end

	def enter_register_information(user) # user[:email_address]

		adobe_id_frame_enter_username(user[:email_address])
		adobe_id_frame_enter_password_2(user[:password])
		adobe_id_frame_retype_password(user[:retype_pass])
		adobe_id_frame_firstname_input(user[:first_name])
		adobe_id_frame_lastname_input(user[:last_name])
		adobe_id_select_country_region(user[:country_region])

		create_btn.click
		sleep 5

		if warning_display? 
			return adobe_id_frame_warning_message.text
		end

	end

	def have_read_and_agree
		read_and_agree_the_term_checkbox.click
		accept_btn.click
	end

    def close_current_page
        @driver.quit
    end

    def warning_display?
        begin
        	@driver.find_element(:xpath, @data_xpath[:register_page][:adobe_id_frame_warning_message])
        	true
    	rescue Selenium::WebDriver::Error::NoSuchElementError
        	false
    	end
    end
end