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

describe "Register -> sign in" do 
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
        EditAccountPage.new(browser).delete_my_account(
            @data_user[$lang][:adobe_id_free_final_step][:id],
            @data_user[$lang][:adobe_id_free_final_step][:password])
    end

    before(:each) do 
        @driver = browser
        @register_page = RegisterPage.new @driver
        @driver.get path_format_locale("/plans/free")
        github_btn.click
    end

    after(:each) do 
        @name_screenshot += @order_it.inc.to_s

        if example.exception != nil
            # Failure only code goes here
            take_screenshot_with_name @name_screenshot
        end
        
        @driver.quit
    end

    context "with " do 

        it "github id connected pgb, sign in successfully" do 
            github_login_field_username.send_keys(@data_user[$lang][:github_id_only][:id])
            github_login_field_password.send_keys(@data_user[$lang][:github_id_only][:password])
            github_login_field_submit.click
            sleep 5
            
            @driver.current_url.should eql @base_url + @data_url[:sign_in_successfully]
        end

        it "the email, Existing Registration Found " do # the email can both login pgb and github, 
            github_login_field_username.send_keys(@data_user[$lang][:email_that_login_both][:id])
            github_login_field_password.send_keys(@data_user[$lang][:email_that_login_both][:password])
            github_login_field_submit.click
            sleep 5
            warning_existing_registration_found.text.should eql @data_str[$lang][:PGB_existing_registration_found]
        end

        it "github id - you must select a country" do 
            github_login_field_username.send_keys(@data_user[$lang][:adobe_id_free_final_step][:id])
            github_login_field_password.send_keys(@data_user[$lang][:adobe_id_free_final_step][:password])
            github_login_field_submit.click
            sleep 5
            github_login_field_agree_to_the_adobe_terms.click
            github_login_field_complete_my_registration.click
            sleep 3
            github_login_field_warning_msg.text.should eql @data_str[$lang][:PGB_alert_you_must_select_a_country]
        end

        it "github id - you must agree to the terms of service" do 
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

        it "github id - sign in successfully" do 
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
end
