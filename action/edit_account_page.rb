
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
		@base_url = base_url
		@driver = driver
		@data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
	end

	def delete_my_account(id, password)
		@driver.get path_format_locale @data_url[:sign_in]
		SignInPage.new(@driver).sign_in_with_adobe_id(id, password)
		@driver.get path_format_locale @data_url[:edit_account]
		delete_my_account_btn.click
		yes_delete_my_account_btn.click
		a = @driver.switch_to.alert
		puts a.text #--> hello
		# a.accept
	end
end