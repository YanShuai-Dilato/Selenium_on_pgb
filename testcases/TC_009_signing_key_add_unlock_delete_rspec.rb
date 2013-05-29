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

describe "TC_009: signing_key_add_and_unlock_rspec" do 
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

    after(:each) do  # Take screenshot in case of failure
        @name_screenshot += @order_it.inc.to_s
        begin
            if example.exception != nil
                take_screenshot_with_name @name_screenshot
            end
        ensure
            @driver.quit
        end
    end

    context "--- ADD & UNLOCK signing-key through 'Edit account' page. " do 
        before(:all) do 
            @driver.get path_format_locale("/people/edit")
            signing_keys_tab.click
        end

        after(:all) do 
            webhelper_delete_all_signing_keys(@data_user[$lang][:adobe_id_free_002][:id], @data_user[$lang][:adobe_id_free_002][:password])
        end

        it "IT_001: the new-added iOS signing_key should be locked after adding successfully " do 
            @edit_account_page.add_ios_signing_key "valid"
            @edit_account_page.get_status_of_1st_ios_signing_key.should eql @data_str[$lang][:apps_signing_key_locked]
        end

        it "IT_002: the above iOS signing Key was unlocked after unlocking it" do 
            @edit_account_page.to_unlock_1st_ios_signing_key 
            sleep 5
            @edit_account_page.get_status_of_1st_ios_signing_key.should eql @data_str[$lang][:apps_signing_key_unlocked]
        end

        it "IT_003: the number of iOS signing_keys should be 0 after deleting the one added above " do 
            @edit_account_page.delete_1st_ios_signing_key
            sleep 10
            ios_key_count = @driver.find_element(:xpath => "//*[@id='person-keys']/table[1]/tbody").find_elements(:tag_name => "tr").count
            ios_key_count.should eql 0
        end

        it "IT_004: the new-added Android signing_key should be locked after adding successfully" do 
            @edit_account_page.add_android_signing_key "valid"
            @edit_account_page.get_status_of_1st_android_signing_key.should eql @data_str[$lang][:apps_signing_key_locked]
        end

        it "IT_005: the second Adroid signing_key should be locked after adding successfully" do 
            @edit_account_page.to_unlock_1st_android_signing_key
            @edit_account_page.get_status_of_1st_android_signing_key.should eql @data_str[$lang][:apps_signing_key_unlocked]
        end

        it "IT_006: the number of Android signing-key should be 0 after deleting the one added above" do 
            @edit_account_page.delete_1st_android_signing_key
            sleep 10
            android_key_count    = @driver.find_element(:xpath => "//*[@id='person-keys']/table[2]/tbody").find_elements(:tag_name => "tr").count
            android_key_count.should eql 0
        end

        it "IT_007: the new-added BlackBerry signing_key should be locked after adding successfully" do 
            @edit_account_page.add_blackberry_signing_key "valid"
            @edit_account_page.get_status_of_1st_blackberry_signing_key.should eql @data_str[$lang][:apps_signing_key_locked]
        end

        it "IT_008: the second BlackBerry signing_key should be locked after adding successfully" do 
            @edit_account_page.to_unlock_1st_blackberry_signing_key
            @edit_account_page.get_status_of_1st_blackberry_signing_key.should eql @data_str[$lang][:apps_signing_key_unlocked]
        end

        it "IT_009: the number of BlackBerry signing-key should be 0 after deleting the one added above" do 
            @edit_account_page.delete_1st_blackberry_signing_key
            sleep 10
            blackberry_key_count = @driver.find_element(:xpath => "//*[@id='person-keys']/table[3]/tbody").find_elements(:tag_name => "tr").count
            blackberry_key_count.should eql 0
        end

    end

end