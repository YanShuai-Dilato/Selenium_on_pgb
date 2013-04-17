

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
        @app_data = YAML::load(File.read(File.expand_path("../../data/data_app.yml",__FILE__)))
	end

	def delete_my_account(id, password)
		SignInPage.new(@driver).sign_in_with_adobe_id(id, password)
		@driver.get path_format_locale("/people/edit")
		delete_my_account_btn.click
		yes_delete_my_account_btn.click
		a = @driver.switch_to.alert
		# puts a.text #--> hello
		a.accept
	end
end