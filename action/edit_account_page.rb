#encoding: utf-8
# operations at page /people/edit

require 'yaml'
require_relative "../tools/edit_account_dialog"
require_relative "../action/sign_in_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"


class EditAccountPage
	include EditAccountDialog
	include BaseEnv
    include ConfigParam

	def initialize(driver)
		init
		@base_url = "https://buildstage.phonegap.com"
		@driver = driver
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url ||= YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user ||= YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str ||= YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
	end

	def delete_my_account(id, password)
		@driver.get path_format_locale @data_url[:sign_in]
		sign_in_page = SignInPage.new @driver, xpath: @data_xpath, user: @data_user, str: @data_str, url: @data_url
		sign_in_page.sign_in_with_github_id(id, password)
		@driver.get path_format_locale @data_url[:edit_account]

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