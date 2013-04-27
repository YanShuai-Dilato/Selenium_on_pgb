#encoding: utf-8

require 'rspec'
require 'rubygems'
require 'selenium-webdriver'
require 'yaml'

require_relative "../action/sign_in_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"

describe "Sign in" do
    include BaseEnv
    include SignInDialog
    include SignInGithubDialog
    include ConfigParam
    include WebdriverHelper

    before(:all) do
        #mixin init function in ConfigParam
        init
        @order_it = WebdriverHelper::Counter.new
        @name_screenshot = "TC_008_IT_"
        @base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    end

    before(:each) do
        @driver = browser # have to start a new instance each time to clean the cache.
        @sign_in_page = SignInPage.new @driver, user: @data_user, str: @data_str, url: @data_url, xpath: @data_xpath
        # @driver.get path_format_locale("/people/sign_in")
    end

    after(:each) do 
        @name_screenshot += @order_it.inc.to_s

        if example.exception != nil
            # Failure only code goes here
            take_screenshot_with_name @name_screenshot
        end
        @driver.quit
    end

    context "with GitHub ID" do
        it "sign in successfully" do 
            @base_url = "https://buildstage.phonegap.com"
            @driver.get path_format_locale("/people/sign_in")
            @sign_in_page.sign_in_with_github_id(@data_user[$lang][:github_id_only][:id],
                                                 @data_user[$lang][:github_id_only][:password])
            sleep 5
            #url should redirect to app page
            @driver.current_url.should == @base_url + @data_url[:sign_in_successfully]
        end
    end

    context "with Adobe ID " do
        it "should sign in successfully" do
            @driver.get path_format_locale("/people/sign_in")
            @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_001][:id],
                                                @data_user[$lang][:adobe_id_free_001][:password])
            #url should redirect to app page
            @driver.current_url.should == @base_url + @data_url[:sign_in_successfully]
        end

        it "invalid email or password" do
            @driver.get path_format_locale("/people/sign_in")
            @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:invalid_user][:id],
                                                @data_user[$lang][:invalid_user][:password])
            sleep 5
            # error message should match the expecation
            error_message_box.text.should eql @data_str[$lang][:not_found_in_database]
        end
    end

    context "I forgot my password" do 
        it "with valid email address" do
            @driver.get path_format_locale("/people/sign_in")
            @tips = @sign_in_page.forget_password_with_valid_email(@data_user[$lang][:adobe_id_free_001][:id])
            @tips.should eql @data_str[$lang][:passwords_send_instructions]
        end

        it "with invalid email address" do 
            @driver.get path_format_locale("/people/sign_in")
            @warnings = @sign_in_page.forget_password_with_invalid_email(@data_user[$lang][:invalid_user][:id])
            @warnings.should eql @data_str[$lang][:PGB_email_not_found]
        end
    end

    context "didn't receive confirmation" do 
        it "privides tips saying you will receive an email with NOT-comfirmed-email address" do 
            @driver.get path_format_locale("/people/sign_in")
            @tips_or_warnings = @sign_in_page.resend_confirmation_instructions(@data_user[$lang][:adobe_id_free_002][:id])
            @tips_or_warnings.should eql @data_str[$lang][:confirmations_send_instructions]
        end

        it "says the email was already confirmed with an already-confirmed email address" do 
            @driver.get path_format_locale("/people/sign_in")
            @tips_or_warnings = @sign_in_page.resend_confirmation_instructions(@data_user[$lang][:adobe_id_free_001][:id])
            @tips_or_warnings.should eql @data_str[$lang][:confirmations_email_confirmed]
        end

        it "says the mail was not found with invalid email address" do 
            @driver.get path_format_locale("/people/sign_in")
            @errors = @sign_in_page.resend_confirmation_instructions(@data_user[$lang][:invalid_user][:id])
            @errors.should eql @data_str[$lang][:PGB_email_not_found]
        end
    end

end