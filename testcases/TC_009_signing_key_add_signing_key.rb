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
        @edit_account_page = EditAccountPage.new @driver, user: @data_user, str: @data_str, url: @data_url, xpath: @data_xpath

        @driver.get path_format_locale("/people/sign_in")
        @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_002][:id],
                                            @data_user[$lang][:adobe_id_free_002][:password])
    end

    after(:all) do 
    	@driver.quit
    end

    after(:each) do 
        @name_screenshot += @order_it.inc.to_s

        if example.exception != nil
            # Failure only code goes here
            take_screenshot_with_name @name_screenshot
        end
    end

	context "--- add signing-key through 'Edit account' page. " do 
        before(:all) do 
            @driver.get path_format_locale("/people/edit")
            signing_keys_tab.click
        end

		it "IT_001: the new-added signing_key should be locked after adding successfully " do 
            @edit_account_page.add_ios_signing_key "valid"
            @edit_account_page.get_status_of_1st_iso_signK.should eql "locked"
		end

        it "IT_002: the second iOS signing Key was locked after adding successfully" do 
            @edit_account_page.add_ios_signing_key "valid"
            @edit_account_page.get_status_of_2nd_iso_signK.should eql "locked"
        end

        
	end

end