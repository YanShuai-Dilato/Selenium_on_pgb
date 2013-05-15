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
		puts "+ <action><edit_account_page> add_iOS_signing_key of #{type}  -- begin"
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
		puts "+ <action><edit_account_page> add_iOS_signing_key of #{type}  -- end"
	end

	def to_make_1st_signingkey_default
		ios_1st_default_btn.click
	end

	def to_make_2nd_signingkey_default
		ios_2nd_default_btn.click
	end
	
	def to_unlock_1st_ios_signingkey
		puts "+ <action><edit_account_page> --- to UNLOCK 1st iOS signingkey --- begin"
		ios_1st_lock_btn.click
		ios_1st_cert_password_input.send_keys @data_signingkey[:ios][:cert_password]
		ios_1st_cert_submit_btn.click
		sleep 5
		puts "+ <action><edit_account_page> --- to UNLOCK 1st iOS signingkey --- end"
	end

	def get_status_of_1st_ios_signingkey
		Selenium::WebDriver::Wait.new(:timeout => 20).until { ios_1st_lock_btn } 
		return ios_1st_lock_btn.attribute("title")
	end

	def to_unlock_2nd_ios_signingkey
		puts "+ <action><edit_account_page> --- to UNLOCK 2nd iOS signingkey --- begin"
		ios_2nd_lock_btn.click
		ios_2nd_cert_password_input.send_keys @data_signingkey[:ios][:cert_password]
		ios_2nd_cert_submit_btn.click
		sleep 5
		puts "+ <action><edit_account_page> --- to UNLOCK 2nd iOS signingkey --- end"
	end

	def get_status_of_2nd_ios_signingkey
		Selenium::WebDriver::Wait.new(:timeout => 20).until { ios_2nd_lock_btn } 
		return ios_2nd_lock_btn.attribute("title")
	end

	def delete_1st_ios_signingkey
		ios_1st_delete_btn.click
		@driver.switch_to.alert.accept
		puts "+ <action><edit_account_page> --- delete_1st_iOS_signingkey DONE"
	end

	def delete_2nd_ios_signingkey
		ios_2nd_delete_btn.click
		@driver.switch_to.alert.accept
		puts "+ <action><edit_account_page> --- delete_2nd_iOS_signingkey DONE"
	end

	def add_android_signing_key valideOne_or_invalidOne	
		type = valideOne_or_invalidOne.upcase
		puts "+ <action><edit_account_page> add_Android_signing_key of #{type}  -- begin"
		if(type == "VALID")
			android_add_key_btn.click
			android_title_input.send_keys @data_signingkey[:name][:valid]
			android_alias_input.send_keys @data_signingkey[:name][:valid]
			android_choose_keystore_btn.send_keys(File.expand_path(@data_signingkey[:android][:valid][:keystore],__FILE__))
			android_submit_btn.click
		else
			android_add_key_btn.click
			puts "Not Implemented yet, will be back later. "
		end
		puts "+ <action><edit_account_page> add_Android_signing_key of #{type}  -- end"
	end

	def to_unlock_1st_android_signingkey
		puts "+ <action><edit_account_page> --- to UNLOCK 1st ANDROID signingkey --- begin"
		android_1st_lock_btn.click
		android_1st_cert_password_input.send_keys @data_signingkey[:android][:cert_password]
		android_1st_keystore_password_input.send_keys @data_signingkey[:android][:keystore_password]
		android_1st_submit_btn.click
		sleep 5
		puts "+ <action><edit_account_page> --- to UNLOCK 1st ANDROID signingkey --- end"
	end

	def get_status_of_1st_android_signingkey
		Selenium::WebDriver::Wait.new(:timeout => 20).until { android_1st_lock_btn } 
		return android_1st_lock_btn.attribute("title")
	end

	def to_unlock_2nd_android_signingkey
		puts "+ <action><edit_account_page> --- to UNLOCK 2nd ANDROID signingkey --- begin"
		android_2nd_lock_btn.click
		android_2nd_cert_password_input.send_keys @data_signingkey[:android][:cert_password]
		android_2nd_keystore_password_input.send_keys @data_signingkey[:android][:keystore_password]
		android_2nd_submit_btn.click
		sleep 5
		puts "+ <action><edit_account_page> --- to UNLOCK 2nd ANDROID signingkey --- end"
	end

	def get_status_of_2nd_android_signingkey
		Selenium::WebDriver::Wait.new(:timeout => 20).until { android_2nd_lock_btn } 
		return android_2nd_lock_btn.attribute("title")
	end

	def delete_1st_android_signingkey
		android_1st_delete_btn.click
		@driver.switch_to.alert.accept
		puts "+ <action><edit_account_page> --- delete_1st_ANDROID_signingkey DONE"
	end

	def delete_2nd_android_signingkey
		android_2nd_delete_btn.click
		@driver.switch_to.alert.accept
		puts "+ <action><edit_account_page> --- delete_2nd_ANDROID_signingkey DONE"
	end

	def add_blackberry_signing_key valideOne_or_invalidOne
		type = valideOne_or_invalidOne.upcase
		puts "+ <action><edit_account_page> add_BlackBerry_signing_key of #{type}  -- begin"
		if(type == "VALID") 
			blackberry_add_key_btn.click
			blackberry_title_input.send_keys @data_signingkey[:name][:valid]
			blackberry_choose_csk_btn.send_keys File.expand_path(@data_signingkey[:blackberry][:valid][:csk],__FILE__)
			blackberry_choose_db_btn.send_keys File.expand_path(@data_signingkey[:blackberry][:valid][:db],__FILE__)
			blackberry_submit_btn.click
		else
			blackberry_add_key_btn.click
			puts "Not Implemented yet, will be back later. BlackBerry"
		end
		puts "+ <action><edit_account_page> add_BlackBerry_signing_key of #{type}  -- end"
	end

	def to_unlock_1st_blackberry_signingkey
		puts "+ <action><edit_account_page> --- to UNLOCK 1st BLACKBERRY signingkey --- begin"
		blackberry_1st_lock_btn.click
		blackberry_1st_key_password_input.send_keys @data_signingkey[:blackberry][:key_password]
		blackberry_1st_submit_btn.click
		sleep 5
		puts "+ <action><edit_account_page> --- to UNLOCK 1st BLACKBERRY signingkey --- end"
	end

	def get_status_of_1st_blackberry_signingkey
		Selenium::WebDriver::Wait.new(:timeout => 20).until { blackberry_1st_lock_btn } 
		return blackberry_1st_lock_btn.attribute("title")
	end

	def to_unlock_2nd_blackberry_signingkey
		puts "+ <action><edit_account_page> --- to UNLOCK 2nd BLACKBERRY signingkey --- begin"
		blackberry_2nd_lock_btn.click
		blackberry_2nd_key_password_input.send_keys @data_signingkey[:blackberry][:key_password]
		blackberry_2nd_submit_btn.click
		sleep 5
		puts "+ <action><edit_account_page> --- to UNLOCK 2nd BLACKBERRY signingkey --- end"
	end

	def get_status_of_2nd_blackberry_signingkey
		Selenium::WebDriver::Wait.new(:timeout => 20).until { blackberry_2nd_lock_btn } 
		return blackberry_2nd_lock_btn.attribute("title")
	end

	def delete_1st_blackberry_signingkey
		blackberry_1st_delete_btn.click
		@driver.switch_to.alert.accept
		puts "+ <action><edit_account_page> --- delete_1st_BLACKBERRY_signingkey DONE"
	end

	def delete_2nd_blackberry_signingkey
		blackberry_2nd_delete_btn.click
		@driver.switch_to.alert.accept
		puts "+ <action><edit_account_page> --- delete_2nd_BLACKBERRY_signingkey DONE"
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