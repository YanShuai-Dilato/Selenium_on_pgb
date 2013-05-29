#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative "../tools/register_dialog"
require_relative "../tools/sign_in_github_dialog"
require_relative "../action/register_page"
require_relative "../action/edit_account_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"

# This TC describes:
#   situations trying to register github free account to sign in. 
describe "TC_005: Register an free plan account with Github ID" do 
    include RegisterDialog
    include SignInGithubDialog
    include BaseEnv
    include ConfigParam
    include WebdriverHelper

    before(:all) do 
        init
        @order_it = WebdriverHelper::Counter.new
        @name_screenshot = "TC_005_IT_"
        @base_url = "https://buildstage.phonegap.com"
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    end

    after(:all) do 
        EditAccountPage.new(browser, xpath: @data_xpath, url: @data_url, str: @data_str, user: @data_user)
            .delete_my_account(
                @data_user[$lang][:adobe_id_free_final_step][:id],
                @data_user[$lang][:adobe_id_free_final_step][:password])
    end

    before(:each) do 
        @driver = browser
        @register_page = RegisterPage.new @driver
        @driver.manage.window.maximize
        @driver.get path_format_locale("/plans/free")
        github_btn.click
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

        it "IT_001: direct to '/apps' page when sign in successfully with github id(which is connected to pgb), " do 
            github_login_field_username.send_keys(@data_user[$lang][:github_id_only][:id])
            github_login_field_password.send_keys(@data_user[$lang][:github_id_only][:password])
            github_login_field_submit.click
            sleep 5
            
            @driver.current_url.should eql @base_url + @data_url[:sign_in_successfully]
        end

        it "IT_002: Got an error message('Existing Registration Found') when use account that can log in both. " do  
            github_login_field_username.send_keys(@data_user[$lang][:email_that_login_both][:id])
            github_login_field_password.send_keys(@data_user[$lang][:email_that_login_both][:password])
            github_login_field_submit.click
            sleep 5
            warning_existing_registration_found.text.should eql @data_str[$lang][:PGB_existing_registration_found]
        end

        it "IT_003: Got an error message when proceed without selecting a country" do 
            github_login_field_username.send_keys(@data_user[$lang][:adobe_id_free_final_step][:id])
            github_login_field_password.send_keys(@data_user[$lang][:adobe_id_free_final_step][:password])
            github_login_field_submit.click
            sleep 5
            github_login_field_agree_to_the_adobe_terms.click
            github_login_field_complete_my_registration.click
            sleep 3
            github_login_field_warning_msg.text.should eql @data_str[$lang][:PGB_alert_you_must_select_a_country]
        end

        it "IT_004: Got an error message when proceed without agree to the terms of service" do 
            github_login_field_username.send_keys(@data_user[$lang][:adobe_id_free_final_step][:id])
            github_login_field_password.send_keys(@data_user[$lang][:adobe_id_free_final_step][:password])
            github_login_field_submit.click
            sleep 5
            github_login_field_select_a_country.find_elements(:tag_name => "option").each do |country| 
                if(country.text == "Japan") 
                    country.click
                    break
                end
            end
            github_login_field_complete_my_registration.click
            sleep 3
            github_login_field_warning_msg.text.should eql @data_str[$lang][:PGB_you_mush_agree_to_the_terms_of_service]
        end

        it "IT_005: page direct to '/apps' after sign in successfully with valid appropriate account . " do 
            github_login_field_username.send_keys(@data_user[$lang][:adobe_id_free_final_step][:id])
            github_login_field_password.send_keys(@data_user[$lang][:adobe_id_free_final_step][:password])
            github_login_field_submit.click
            sleep 5
            github_login_field_select_a_country.find_elements(:tag_name => "option").each do |country| 
                if(country.text == "United States") 
                    puts country.text
                    country.click
                    break
                end
            end
            github_login_field_agree_to_the_adobe_terms.click
            github_login_field_complete_my_registration.click
            sleep 15
            @driver.current_url.should eql @base_url + @data_url[:sign_in_successfully]
        end

end
