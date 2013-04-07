#encoding: utf-8
require 'rspec'
require 'rubygems'
require 'selenium-webdriver'
require 'yaml'

require_relative "../action/sign_in_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"

describe "Sign in" do
    include BaseEnv
    include SignInDialog
    include SignInGithubDialog
    include ConfigParam

    before(:all) do
        #mixin init function in ConfigParam
        init
        @base_url = base_url
        @sign_in_page = nil
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    end

    before(:each) do
        @driver = browser # have to start a new instance each time to clean the cache.
        @sign_in_page = SignInPage.new(@driver)
        @driver.get path_format_locale("/people/sign_in")
    end

    after(:each) do 
        if example.exception != nil
            @driver.save_screenshot 'screenshot.png'
        end    
        @sign_in_page.close_current_browser
    end

    context "with GitHub ID" do
        it "sign in successfully" do 
            @sign_in_page.sign_in_with_github_id(@data_user[$lang][:free_github][:id],@data_user[$lang][:free_github][:password])
            #url should redirect to app page
            @driver.current_url.should == @data_url[:sign_in_successfully]
        end
    end

    context "with Adobe ID " do
        it "should sign in successfully" do 
            @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:free_adobeid][:id],@data_user[$lang][:free_adobeid][:password])
            #url should redirect to app page
            @driver.current_url.should == @data_url[:sign_in_successfully]
        end

        it "invalid email or password" do
            @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:invalid_user_id][:id],@data_user[$lang][:invalid_user_id][:password])
            sleep 5
            #error message should match the expecation
            error_message_box.text.should == @data_str[$lang][:not_found_in_database]
        end
    end

    context "-> I forgot my password" do 
        it "with valid email address" do
            @tips = @sign_in_page.forget_password_with_valid_email(@data_user[$lang][:free_adobeid][:id])
            @tips.should eql @data_str[$lang][:receive_an_email_on_recovering]
        end

        it "with invalid email address" do 
            @warnings = @sign_in_page.forget_password_with_invalid_email(@data_user[$lang][:invalid_user][:id])
            @warnings.should eql @data_str[$lang][:email_not_found]
        end
    end

    context "didn't receive confirmation" do 
        it "with valid email address" do 
            @tips = @sign_in_page.confirmation_instru_with_valid_email(@data_user[$lang][:free_adobeid][:id])
            @tips.should eql @data_str[$lang][:email_already_confirmed]
        end

        it "with invalid email address" do 
            @errors = @sign_in_page.confirmation_instru_with_invalid_email(@data_user[$lang][:invalid_user][:id])
            @errors.should eql @data_str[$lang][:email_not_found]
        end
    end

end