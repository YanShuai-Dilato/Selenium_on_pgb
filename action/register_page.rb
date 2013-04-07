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

	def create_an_adobe_id_with_valid_account(user)
		enter_register_information(user)
		create
		sleep 5
		accept_terms
		accept_and_go_on
		sleep 5
	end

	def create_an_adobe_id_with_invalid_email_address(user)
		enter_register_information(user)
		create
		sleep 5
		get_warning_message
    end

    def create_an_abode_id_with_not_matched_password(user)
        enter_register_information(user)
        create
        sleep 5
        get_warning_message
    end

    def create_an_adobe_id_with_invalid_first_name(user)
        enter_register_information(user)
        create
        sleep 5
        get_warning_message
    end

    def create_an_adobe_id_with_invalid_last_name(user)
        enter_register_information(user)
        create
        sleep 5
        get_warning_message
    end

    def close_current_page
        @driver.quit
    end
end