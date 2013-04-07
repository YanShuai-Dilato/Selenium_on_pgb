
module SignInGithubDialog

	def enter_account(user) 
		git_id_textinput.send_keys(user[:username])
		git_password_textinput.send_keys(user[:password])
		git_sign_in_btn.click
	end

	def git_id_textinput
		@git_id_textinput ||= @driver.find_element(:xpath => @data_xpath[:sign_in_github_page][:username_or_email])
	end
	def git_password_textinput
		@git_password_textinput ||= @driver.find_element(:xpath => @data_xpath[:sign_in_github_page][:password])
	end
	def git_sign_in_btn
		@git_sign_in_btn ||= @driver.find_element(:xpath => @data_xpath[:sign_in_github_page][:sign_in])
	end
end