#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative "../action/sign_in_page"
require_relative "../action/edit_account_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"
require_relative "../tools/edit_account_dialog"

describe "TC_009: Signing-Key_Add_Signing_key" do 
	include BaseEnv
    include SignInDialog
    include SignInGithubDialog
    include EditAccountDialog
    include ConfigParam
    include WebdriverHelper

    before(:all) do 
    	init
        @order_it = WebdriverHelper::Counter.new
        @name_screenshot = "TC_008_IT_"
        @base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))

        @driver = browser # have to start a new instance each time to clean the cache.
        @driver.manage.window.maximize
        @sign_in_page = SignInPage.new @driver, user: @data_user, str: @data_str, url: @data_url, xpath: @data_xpath

        @driver.get path_format_locale("/people/sign_in")
        @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_001][:id],
                                            @data_user[$lang][:adobe_id_free_001][:password])
        @driver.get path_format_locale("/people/edit")
        signing_keys_tab.click
    end

    after(:all) do 
    	@driver.quit
    end

	context "--- add signing-key through 'Edit account' page. " do 
		before(:each) do 

		end


		after(:each) do 

		end
		
		it "IT_001" do 

		end
	end

	context "--- Unlock and Lock signing key " do 

	end

	context "--- Delete signing-key" do 

	end
end