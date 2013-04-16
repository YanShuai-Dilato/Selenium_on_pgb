#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative "../tools/register_dialog"
require_relative "../tools/sign_in_github_dialog"
require_relative "../action/register_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"

describe "Register -> change plan (Free -> Paid)" do 
	include RegisterDialog
    include SignInGithubDialog
	include BaseEnv
	include ConfigParam

	before(:all) do 
		init
		@driver = browser
		@sign_in_page = SignInPage.new @driver
		# @base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))

        @base_url = base_url
        @driver = browser
        @new_app_page = NewAppPage.new(@driver)
        @driver.get path_format_locale("/people/sign_in")
        SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_paid][:id],
                                                      @data_user[$lang][:adobe_id_free_paid][:password])
        sleep 5
	end

	after(:all) do 
		@sign_in_page.close_current_browser
	end

	


end