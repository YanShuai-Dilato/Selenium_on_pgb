
module EditAccountDialog
	def delete_my_account_btn
		@driver.find_element(:xpath => @data_xpath[:edit_account_page][:delete_my_account])
	end
	def yes_delete_my_account_btn
		@driver.find_element(:xpath => @data_xpath[:edit_account_page][:yes_delete_my_account])
	end
	
end