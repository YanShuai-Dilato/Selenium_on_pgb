#encoding: utf-8

require_relative "../lib/webdriver_helper"

module EditAccountDialog
	include WebdriverHelper

# --- Account Details Tab
	def account_details_tab
		@driver.find_element(:xpath => @data_xpath[:edit_account_page][:account_details_tab])
	end
	def delete_my_account_btn
		@driver.find_element(:xpath => @data_xpath[:edit_account_page][:delete_my_account])
	end
	def yes_delete_my_account_btn
		@driver.find_element(:xpath => @data_xpath[:edit_account_page][:yes_delete_my_account])
	end
# --- / Account Details Tab

# --- Private code hosting Tab
	def private_code_hosting_tab
		@driver.find_element(:xpath => @data_xpath[:edit_account_page][:private_code_hosting_tab])
	end
# --- / Private code hosting Tab


# --- Signing Keys Tab
	def signing_keys_tab
		@driver.find_element(:xpath => @data_xpath[:edit_account_page][:signing_keys_tab])
	end
	def ios_add_key_btn
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_add_key_btn])
	end
	def ios_title_input
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_title_input])
	end
	def ios_choose_cert_file_btn
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_choose_cert_file_btn])
	end
	def ios_choose_prov_file_btn
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_choose_prov_file_btn])
	end
	def ios_cacel_btn
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_cacel_btn])
	end
	def ios_submit_btn
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_submit_btn])
	end
	def ios_1st_default_btn
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_1st_default_btn])
	end
	def ios_1st_lock_btn
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_1st_lock_btn])
	end
	def ios_1st_delete_btn
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_1st_delete_btn])
	end
	def ios_2nd_default_btn
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_2nd_default_btn])
	end
	def ios_2nd_lock_btn
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_2nd_lock_btn])
	end
	def ios_2nd_delete_btn
		highlight_and_return @driver.find_element(:xpath => @data_xpath[:edit_account_page][:ios_2nd_delete_btn])
	end
	
# --- / Sign Keys Tab

# highlight utility
	def highlight_and_return field
        highlight field
        return field
    end

end