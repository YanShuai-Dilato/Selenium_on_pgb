# register_page.rb

require_relative "../lib/config_param"
require_relative "../tools/register_dialog"

class RegisterPage
	include ConfigParam
	include RegisterDialog

	def initialize(driver)
		@driver = driver
	end

	def reset_page_content
		@fields = get_all_fields
		@fields.each do |field|
			field.clear
		end
	end

	def enter_register_information(user) # user[:email_address]
		enter_email(user[:email_address])
		enter_password(user[:password])
		enter_retype_password(user[:retype_pass])
		enter_first_name(user[:first_name])
		enter_last_name(user[:last_name])
		select_country_region(user[:country_region])
		create_btn.click
	end

	def have_read_and_agree
		checkbox_read_and_agree.click
		btn_accept.click
	end

    def close_current_page
        @driver.quit
    end
end