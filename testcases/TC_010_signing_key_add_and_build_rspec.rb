#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative "../action/sign_in_page"
require_relative "../action/edit_account_page"
require_relative "../action/new_app_page"
require_relative "../action/app_builds_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"
require_relative "../tools/edit_account_dialog"
require_relative "../tools/new_app_dialog"

describe "TC_010: signing_key_add_and_build_rspec" do 
    include BaseEnv
    include SignInDialog
    include SignInGithubDialog
    include EditAccountDialog
    include NewAppDialog # rebuild_all_btn
    include AppBuildsDialog
    include ConfigParam
    include WebdriverHelper

    before(:all) do 
        init
        @order_it = WebdriverHelper::Counter.new
        @name_screenshot = "TC_010_IT_"
        @base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
        @data_signing_key = YAML::load(File.read(File.expand_path("../../data/data_signing_key.yml", __FILE__)))

        @driver = browser # have to start a new instance each time to clean the cache.
        @driver.manage.window.maximize
        @driver.execute_script("window.resizeTo(screen.width,screen.height)")
        @sign_in_page = SignInPage.new @driver, user: @data_user, str: @data_str, url: @data_url, xpath: @data_xpath
        @new_app_page = NewAppPage.new(@driver)
        @app_builds_page = AppBuildsPage.new(@driver, user: @data_user, str: @data_str, url: @data_url, xpath: @data_xpath)
        @edit_account_page = EditAccountPage.new @driver, user: @data_user, str: @data_str, url: @data_url, xpath: @data_xpath

        @driver.get path_format_locale("/people/sign_in")
        @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_002][:id],
                                            @data_user[$lang][:adobe_id_free_002][:password])
        sleep 10
    end

    after(:all) do 
        @driver.quit
        # webhelper_delete_all_signing_keys(@data_user[$lang][:adobe_id_free_002][:id], @data_user[$lang][:adobe_id_free_002][:password])
        webhelper_delete_all_apps(@data_user[$lang][:adobe_id_free_002][:id], @data_user[$lang][:adobe_id_free_002][:password])
    end

    after(:each) do 
        @name_screenshot += @order_it.inc.to_s

        if example.exception != nil
            # Failure only code goes here
            take_screenshot_with_name @name_screenshot
        end
    end

    context "--- " do 
        before(:all) do 
            @driver.get @base_url + "/people/edit"
            puts "+ Page gets to: #{@base_url}/people/edit -> Tab: Signing-Keys"
            sleep 5
            signing_keys_tab.click
            # Add valid and invalid signing_key for each app
            # @edit_account_page.add_ios_signing_key "valid"
            # @edit_account_page.add_ios_signing_key "invlaid"
            # @edit_account_page.to_unlock_1st_ios_signing_key
            # @edit_account_page.to_unlock_2nd_ios_signing_key_with_invalid_password
            # @edit_account_page.to_make_1st_signing_key_default

            # @edit_account_page.add_android_signing_key "valid"
            # @edit_account_page.add_android_signing_key "invalid"
            # @edit_account_page.to_unlock_1st_android_signing_key
            # @edit_account_page.to_unlock_2nd_android_signing_key_with_invalid_password

            # @edit_account_page.add_blackberry_signing_key "valid"
            # @edit_account_page.add_blackberry_signing_key "invalid"
            # @edit_account_page.to_unlock_1st_blackberry_signing_key
            # @edit_account_page.to_unlock_2nd_blackberry_signing_key_with_invalid_password

            @driver.get @base_url + "/apps"
            puts "+ Page gets to: #{@base_url}/apps"
            @new_app_page.new_public_app_with_repo
            @current_app_id = @new_app_page.get_first_app_id
            current_url = @driver.current_url
            puts "+ current app ID: #{@current_app_id}"
            puts "+ current_url:    #{current_url}"
            
            ready_to_build_btn.click
            puts "+ 'ready_to_build_btn' was clicked. "
            # sleep 10
            @driver.get "#{current_url}/#{@current_app_id}/builds"
            puts "+ Page got to:   #{current_url}/#{@current_app_id}/builds"
            sleep 10
        end

        # it "IT_001: iOS: The label of iOS signing-key select should be 'No Key selected' by default" do 
        #     ios_signing_key_label.text.should eql @data_str[$lang][:app_builds_no_key_selected]
        # end

        # it "IT_002: Android: the label of Android signing-key select should be 'No Key selected' by default " do 
        #     android_signing_key_label.text.should eql @data_str[$lang][:app_builds_no_key_selected]
        # end

        # it "IT_003: BlackBerry: the label of BlackBerry signing-key select should be 'No Key selected' by default" do 
        #     blackberry_signing_key_label.text.should eql @data_str[$lang][:app_builds_no_key_selected]
        # end

        it "IT_004: iOS: The signing-key used by the app was the default signing-key " do 
            name = @app_builds_page.ios_get_signing_key_name_of_id @current_app_id
            name.should eql @data_signing_key[:ios][:name_valid]
        end

        # it "IT_005: iOS: the signing-key was locked after adding one. " do 
        #     Selenium::WebDriver::Wait.new(:timeout => 300).until { ios_signing_key_dropdown_select.attribute("disabled") == nil }
        #     dropdown = Selenium::WebDriver::Support::Select.new(ios_signing_key_dropdown_select)
        #     dropdown.select_by(:text, @data_str[$lang][:apps_builds_add_a_key])
        #     @app_builds_page.ios_add_signing_key
        #     @app_builds_page.ios_get_status_of_the_signing_key.should eql @data_str[$lang][:apps_signing_key_locked]
        # end

        # it "IT_006: iOS: got an error message after building with a locked signing_key" do 
        #     rebuild_all_btn.click
        #     sleep 10
        #     txt = @app_builds_page.ios_get_error_msg_of_the_signing_key.strip
        #     puts "+ <testcases><TC_010> iOS: Error msg with locked key: #{txt}"
        #     txt.should eql @data_str[$lang][:error_msg_ios_build_with_locked_signing_key]
        # end

        # it "IT_007: iOS: the signing-key used was the signing-key just added after unlocking the key and then building " do 
        #     @app_builds_page.to_unlock_ios_signing_key
        #     rebuild_all_btn.click
        #     puts "+ <testcases><TC_010> iOS: after 'rebuild_all' button was clicked"
        #     sleep 10
        #     signing_key_name = @app_builds_page.ios_get_signing_key_name_of_id @current_app_id
        #     signing_key_name.should eql "abc#{@data_signing_key[:ios][:name_valid]}"
        # end

        # it "IT_008: Android: the signing-key was locked after adding one" do 
        #     Selenium::WebDriver::Wait.new(:timeout => 300).until { android_signing_key_dropdown_select.attribute("disabled") == nil }
        #     dropdown = Selenium::WebDriver::Support::Select.new(android_signing_key_dropdown_select)
        #     dropdown.select_by(:text, @data_str[$lang][:apps_builds_add_a_key])
        #     @app_builds_page.android_add_signing_key
        #     @app_builds_page.android_get_status_of_the_signing_key.should eql @data_str[$lang][:apps_signing_key_locked]
        # end

        # it "IT_009: Android: got an error message after building with a locked signing-key" do 
        #     rebuild_all_btn.click
        #     sleep 10
        #     txt = @app_builds_page.android_get_error_msg_of_the_signing_key.strip
        #     puts "+ <testcases><TC_010> Android: Error msg with locked key: #{txt}"
        #     txt.should eql @data_str[$lang][:error_msg_android_build_with_locked_signing_key]
        # end

        # it "IT_010: Android: the signing-key used was the signing-key just added after unlocking the key and then building" do 
        #     @app_builds_page.to_unlock_android_signing_key
        #     rebuild_all_btn.click 
        #     puts "+ <testcases><TC_010> BlackBerry: after 'rebuild_all' button was clicked "
        #     sleep 10
        #     signing_key_name = @app_builds_page.android_get_signing_key_name_of @current_app_id
        #     signing_key_name.should eql "abc#{@data_signing_key[:android][:name_valid]}"
        # end

        # it "IT_011: BlackBerry: The signing-key was locked after adding one. " do 
        #     Selenium::WebDriver::Wait.new(:timeout => 300).until { blackberry_signing_key_dropdown_select.attribute("disabled") == nil }
        #     dropdown = Selenium::WebDriver::Support::Select.new(blackberry_signing_key_dropdown_select)
        #     dropdown.select_by(:text, @data_str[$lang][:apps_builds_add_a_key])
        #     @app_builds_page.blackberry_add_signing_key
        #     @app_builds_page.blackberry_get_status_of_the_signing_key.should eql @data_str[$lang][:apps_signing_key_locked]
        # end

        # it "IT_012: BlackBerry: Got an error message after building with a locked signing-key " do 
        #     rebuild_all_btn.click
        #     sleep 10
        #     txt = @app_builds_page.blackberry_get_error_msg_of_the_signing_key.strip
        #     puts "+ <testcases><TC_010> BlackBerry: Error msg with locked key: #{txt}"
        #     txt.should eql @data_str[$lang][:error_msg_blackberry_build_with_locked_signing_key]
        # end

        # it "IT_013: BlackBerry: the signing_key used was the signing_key just added after unlocking the key and building" do 
        #     @app_builds_page.to_unlock_blackberry_signing_key
        #     rebuild_all_btn.click # NewAppDialog
        #     puts "+ <testcases><TC_010> BlackBerry: after 'rebuild_all' button was clicked "
        #     sleep 10
        #     signing_key_name = @app_builds_page.blackberry_get_signing_key_name_of @current_app_id
        #     signing_key_name.should eql "abc#{@data_signing_key[:blackberry][:name_valid]}"
        # end

    end

end