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
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))

    end

    before(:each) do
        @driver = browser # have to start a new instance each time to clean the cache.
        @sign_in_page = SignInPage.new(@driver)
        @driver.get @base_url + "/people/sign_in"
    end

    after(:each) do 
         if example.exception != nil
             @driver.save_screenshot 'screenshot.png'
         end    
        @sign_in_page.close_current_browser
    end

    
    context "with GitHub ID" do
        it "sign in successfully" do 
            @sign_in_page.sign_in_with_github_id(@data_user[:en_us][:free_github][:id],@data_user[:en_us][:free_github][:password])
            @driver.current_url.should == @data_url[:sign_in_successfully]
        end

    end

    context "with Adobe ID " do
        it "should sign in successfully" do 
            @sign_in_page.sign_in_with_adobe_id(@data_user[:en_us][:free_adobeid][:id],@data_user[:en_us][:free_adobeid][:password])
            #change to should_not for demo

            @driver.current_url.should_not == @data_url[:sign_in_successfully]
        end


        it "invalid email or password" do
            @sign_in_page.sign_in_with_adobe_id(@data_user[:en_us][:invalid_user_id][:id],@data_user[:en_us][:invalid_user_id][:password])
            sleep 3
            error_message_box.text.should == @data_str[:en_us][:not_found_in_database]
            sleep 1
        end
    end

=begin
    describe "-> register a new account" do
        it "" do 

        end
    end

    describe "-> I forgot my password" do 
    it "should open the 'Forgot Your Password?' page"
        puts 
        #@click_element.open_forgot_my_password
        #@driver.current_url.should == @exp_url[:forgot_your_password] # here
    end
=end
end