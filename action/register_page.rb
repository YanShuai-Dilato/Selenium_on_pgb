# register_page.rb

require_relative "../lib/config_param"
require_relative "../tools/register_dialog"

class RegisterPage
	include ConfigParam
	include RegisterDialog

	def initialize(driver)
		@driver = driver
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
		warning_message.text
	end

	def have_read_and_agree
		checkbox_read_and_agree.click
		btn_accept.click
	end

    def close_current_page
        @driver.quit
    end
end