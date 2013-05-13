#encoding: utf-8
# operations at page /people/edit

require 'yaml'
require_relative "../tools/edit_account_dialog"
require_relative "../action/sign_in_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"


class EditAccountPage
	include EditAccountDialog
	include BaseEnv
    include ConfigParam
    include WebdriverHelper

	def initialize(driver, options = {})
		puts "+ <action><edit_account_page> initialize EditAccountPage -- begin"
		init
		@driver = driver
        @data_xpath = options.fetch(:xpath)
        @data_str = options.fetch(:str)
        @data_user = options.fetch(:user)
        @data_url = options.fetch(:url)
        @data_signingkey = YAML::load(File.read(File.expand_path("../../data/data_signingkey.yml",__FILE__)))
        puts "+ <action><edit_account_page> initialize EditAccountPage -- end"
	end
# Signing Key related --- begin
	def add_ios_signing_key valideOne_or_invalidOne = "valid"
		type = valideOne_or_invalidOne.upcase
		puts "+ <action><edit_account_page> add_ios_signing_key of #{type}  -- begin"
		if(type == "VALID")
			ios_add_key_btn.click
			ios_title_input.send_keys(@data_signingkey[:name][:valid])
			ios_choose_cert_file_btn.send_keys(File.expand_path(@data_signingkey[:ios][:valid][:cert],__FILE__))
			ios_choose_prov_file_btn.send_keys(File.expand_path(@data_signingkey[:ios][:valid][:profile],__FILE__))
			ios_submit_btn.click
		else
			ios_add_key_btn.click
			ios_title_input.send_keys(@data_signingkey[:name][:invalid])
			ios_choose_cert_file_btn.send_keys(File.expand_path(@data_signingkey[:ios][:invalid][:cert],__FILE__))
			ios_choose_prov_file_btn.send_keys(File.expand_path(@data_signingkey[:ios][:invalid][:profile],__FILE__))
			ios_submit_btn.click
		end
		puts "+ <action><edit_account_page> add_ios_signing_key of #{type}  -- end"
	end

	def get_status_of_1st_iso_signK
		Selenium::WebDriver::Wait.new(:timeout => 20).until { ios_1st_lock_btn } 
		return ios_1st_lock_btn.attribute("title")
	end

	def get_status_of_2nd_iso_signK
		Selenium::WebDriver::Wait.new(:timeout => 20).until { ios_2nd_lock_btn } 
		return ios_2nd_lock_btn.attribute("title")
	end


# Signing Key related   --- end


	def delete_my_account(id, password)
		@driver.get path_format_locale(base_url = "https://buildstage.phonegap.com", @data_url[:sign_in])
		sign_in_page = SignInPage.new @driver, xpath: @data_xpath, user: @data_user, str: @data_str, url: @data_url
		sign_in_page.sign_in_with_github_id(id, password)
		@driver.get path_format_locale(base_url = "https://buildstage.phonegap.com", @data_url[:edit_account])

		@driver.execute_script("document.getElementById('delete-account').style['display'] = 'block'")
		puts "+ after executing script"
		sleep 3
		
		@driver.find_element(:xpath => "//*[@id='delete-account']/section/fieldset/a").click  

		a = @driver.switch_to.alert
		a.accept
		# a.dismiss
		sleep 5
		puts "+ user account #{id} deleted"
		@driver.quit
	end
end