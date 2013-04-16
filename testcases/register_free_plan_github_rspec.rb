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

describe "Register -> sign in" do 
    include RegisterDialog
    include SignInGithubDialog
    include BaseEnv
    include ConfigParam

    before(:all) do 
        init
        @base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    end

    before(:each) do 
        @driver = browser
        @register_page = RegisterPage.new @driver
        @driver.get path_format_locale("/plans/free")
        github_btn.click
    end

    after(:each) do 
        @register_page.close_current_page
    end

    context "Github ID" do 
        it "new github id" do # need to authorize app from github
            github_login_field_username.send_keys(@data_user[$lang][:github_id_only][:id])
            github_login_field_password.send_keys(@data_user[$lang][:github_id_only][:password])
            github_login_field_submit.click
            sleep 5
            github_login_field_authorize_app.click
            @driver.current_url.should eql @data_url[:sign_in_successfully]
        end

        it "github id already disconnected - you must select a country" do 
            github_login_field_username.send_keys(@data_user[$lang][:github_id_already_disconnected][:id])
            github_login_field_password.send_keys(@data_user[$lang][:github_id_already_disconnected][:password])
            github_login_field_submit.click
            sleep 5
            github_login_field_complete_my_registration.click
            github_login_field_warning_msg.text.should eql @data_str[$lang][:PGB_alert_you_must_select_a_country]
        end

        it "github id already disconnected - you must agree to the terms of service" do 
            github_login_field_username.send_keys(@data_user[$lang][:github_id_already_disconnected][:id])
            github_login_field_password.send_keys(@data_user[$lang][:github_id_already_disconnected][:password])
            github_login_field_submit.click
            sleep 5
            github_login_field_select_a_country.find_elements(:tag_name => "option").each do |country| 
                if(country.text == "English") 
                    country.click
                    break
                end
            end
            github_login_field_complete_my_registration.click
            github_login_field_warning_msg.text.should eql @data_str[$lang][:PGB_you_mush_agree_to_the_terms_of_service]
        end

        it "github id already disconnected - you must agree to the terms of service" do 
            github_login_field_username.send_keys(@data_user[$lang][:github_id_already_disconnected][:id])
            github_login_field_password.send_keys(@data_user[$lang][:github_id_already_disconnected][:password])
            github_login_field_submit.click
            sleep 5
            github_login_field_select_a_country.find_elements(:tag_name => "option").each do |country| 
                if(country.text == "English") 
                    country.click
                    break
                end
            end
            github_login_field_agree_to_the_adobe_terms.click
            github_login_field_complete_my_registration.click
            @driver.current_url.should eql @data_url[:sign_in_successfully]
        end

        it "github id already connected" do # can connect and sign in directly. 
            github_login_field_username.send_keys(@data_user[$lang][:github_id_already_connected][:id])
            github_login_field_password.send_keys(@data_user[$lang][:github_id_already_connected][:password])
            github_login_field_submit.click
            sleep 5
            @driver.current_url.should eql @data_url[:sign_in_successfully]
        end
    end

end
