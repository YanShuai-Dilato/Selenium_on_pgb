
module SignInGithubDialog
	def gh_username
		@driver.find_element(:xpath => @data[:sign_in_github_page][:username_or_email])
	end
	def gh_password
		@driver.find_element(:xpath => @data[:sign_in_github_page][:password])
	end
	def gh_sign_in
		@driver.find_element(:xpath => @data[:sign_in_github_page][:sign_in])
	end
end