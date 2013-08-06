#encoding: utf-8

require_relative "../lib/webdriver_helper"

module SignInGithubDialog
    include WebdriverHelper

	def enter_github_account_and_sign_in_with(user) 
		git_id_textinput.send_keys(user[:id])
		git_password_textinput.send_keys(user[:password])
		git_sign_in_btn.click
	end

	def git_id_textinput
		@driver.find_element(:xpath => @data_xpath[:sign_in_github_page][:username_or_email])
	end
	def git_password_textinput
		@driver.find_element(:xpath => @data_xpath[:sign_in_github_page][:password])
	end
	def git_sign_in_btn
		@driver.find_element(:xpath => @data_xpath[:sign_in_github_page][:sign_in_btn])
	end

	def allow_access_btn
		@driver.find_element(:xpath => @data_xpath[:sign_in_github_page][:allow_access_btn])
	end

end