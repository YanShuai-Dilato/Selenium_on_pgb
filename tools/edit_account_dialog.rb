#encoding: utf-8

module EditAccountDialog

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
	
# --- / Sign Keys Tab
end