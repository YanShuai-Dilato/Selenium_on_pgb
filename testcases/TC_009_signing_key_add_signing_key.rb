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
        @name_screenshot = "TC_009_IT_"
        @base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))

        @driver = browser # have to start a new instance each time to clean the cache.
        @driver.manage.window.maximize
        @driver.execute_script("window.resizeTo(screen.width,screen.height)")
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

        after(:all) do 
            # ios_key_count        = @driver.find_element(:xpath => "//*[@id='person-keys']/table[1]/tbody").find_elements(:tag_name => "tr").count
            # android_key_count    = @driver.find_element(:xpath => "//*[@id='person-keys']/table[2]/tbody").find_elements(:tag_name => "tr").count
            # blackberry_key_count = @driver.find_element(:xpath => "//*[@id='person-keys']/table[3]/tbody").find_elements(:tag_name => "tr").count

            # puts "IOS KEY COUNT: #{ios_key_count}"
            # puts "ANDROID KEY COUNT: #{android_key_count}"
            # puts "BLACKBERRY KEY COUNT: #{blackberry_key_count}"

            @edit_account_page.delete_ios_signingkeys
            @edit_account_page.delete_android_signingkeys
            @edit_account_page.delete_blackberry_signingkeys
        end

        it "IT_001: the new-added iOS signing_key should be locked after adding successfully " do 
            @edit_account_page.add_ios_signing_key "valid"
            @edit_account_page.get_status_of_1st_iso_signK.should eql "locked"
        end

        it "IT_002: the second iOS signing Key was locked after adding successfully" do 
            @edit_account_page.add_ios_signing_key "valid"
            @edit_account_page.get_status_of_2nd_iso_signK.should eql "locked"
        end

        it "IT_003: the new-added Android signing_key should be locked after adding successfully" do 
            @edit_account_page.add_android_signing_key "valid"
            @edit_account_page.get_status_of_1st_android_signK.should eql "locked"
        end

        it "IT_004: the second Adroid signing_key should be locked after adding successfully" do 
            @edit_account_page.add_android_signing_key "valid"
            @edit_account_page.get_status_of_2nd_android_signK.should eql "locked"
        end

        it "IT_005: the new-added BlackBerry signing_key should be locked after adding successfully" do 
            @edit_account_page.add_blackberry_signing_key "valid"
            @edit_account_page.get_status_of_1st_blackberry_signK.should eql "locked"
        end

        it "IT_006: the second BlackBerry signing_key should be locked after adding successfully" do 
            @edit_account_page.add_blackberry_signing_key "valid"
            @edit_account_page.get_status_of_2nd_blackberry_signK.should eql "locked"
        end


	end

end