#encoding: utf-8

# Please ignore this one. 
# For there are some account-related issues we are still working on. 
# It will be ok later. 

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative "../tools/register_dialog"
require_relative "../tools/sign_in_github_dialog"
require_relative "../tools/new_app_dialog"
require_relative "../tools/anywareContainer"
require_relative "../action/register_page"
require_relative "../action/new_app_page"
require_relative "../action/sign_in_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"

describe "TC_007: Register -> upgrade plan (Free -> Paid)" do 
    include RegisterDialog
    include NewAppDialog
    include SignInGithubDialog
    include AnywareContainer
    include BaseEnv
    include ConfigParam
    include WebdriverHelper

    before(:all) do 
        init
        @order_of_it = WebdriverHelper::Counter.new
        @name_screenshot = "TC_007_IT_"
        @base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    end

    before(:each) do 
        @driver = browser
        @driver.manage.window.maximize
        @sign_in_page = SignInPage.new @driver, url: @data_url, xpath: @data_xpath, user: @data_user
        @new_app_page = NewAppPage.new @driver
        @driver.get path_format_locale("/people/sign_in")

        @sign_in_page.sign_in_with_adobe_id(
            @data_user[$lang][:adobe_id_for_upgrade_purpose_support_area][:id],
            @data_user[$lang][:adobe_id_for_upgrade_purpose_support_area][:password])
        begin
            sleep 5
        end until @driver.current_url == @base_url + @data_url[:sign_in_successfully]
        puts "+ current_url -> #{@driver.current_url}"
        puts "+ data_url[:sign_in_successfully] -> #{@base_url}#{@data_url[:sign_in_successfully]}"

        puts "+ new_app_with_zip in new_app_page.rb"
        sleep 10
        if @new_app_page.new_app_btn_display?
            new_app_btn.click
        end
        puts "+ after new_app_btn.click"

        private_tab.click
        puts "+ after private_tab.click"

        if !@new_app_page.private_app_no?
            @new_app_page.new_app_with_zip
            sleep 5
        end
    end

    after(:each) do  # Take screenshot in case of failure
        @name_screenshot += @order_of_it.inc.to_s
        begin
            if example.exception != nil
                take_screenshot_with_name @name_screenshot
            end
        ensure
            @driver.quit
        end
    end

    it "IT_001: page does direct to 'http://creative.adobe.com' page, when select the 'Creative Cloud Membership' " do 
        upgrade_link.click
        begin
            sleep 5
        end until @driver.current_url == @base_url + @data_url[:register_page]
        start_at_9_99_btn.click

        sleep 10

        if isElementPreset?(:tag_name, "iframe") 
            @driver.switch_to.frame(0)
            puts "+ after @driver.switch_to.frame(0)"
            sleep 5    
            adobe_id_frame_enter_email(@data_user[$lang][:adobe_id_for_upgrade_purpose_support_area][:id])
               adobe_id_frame_enter_password(@data_user[$lang][:adobe_id_for_upgrade_purpose_support_area][:password])
             adobe_id_frame_sign_in_btn.click
            sleep 3
            @driver.switch_to.default_content
            puts "+ after @driver.switch_to.default_content"
        end

        @driver.find_element(:xpath => "//*[@id='cc-plan-btn']").click
        sleep 5
        @driver.current_url.should eql "https://creative.adobe.com/plans"
    end
=begin
    it "does upgrade successfully and then can create more private apps, when select the 9.99/mo and fill valid infomation" do 
        
        upgrade_link.click
        sleep 3
        start_at_9_99_btn.click

        if isElementPreset?(:tag_name, "iframe") 
            sleep 5
            @driver.switch_to.frame(0)
            enter_email(@data_user[$lang][:adobe_id_for_upgrade_purpose_support_area][:id])
            enter_password(@data_user[$lang][:adobe_id_for_upgrade_purpose_support_area][:password])
            sign_in_btn.click
            sleep 3
            @driver.switch_to.default_content
        end
    
        choose_payplan_9_99_link.click
        i_agree_to_the_terms_above.click    
        sleep 30

        fill_Payment_Card
        fill_Billing_Address
        payment_continue_btn.click
        sleep 5

        payment_confirm_btn.click
        sleep 5

        begin
            sleep 5
        end until @driver.current_url == @base_url + @data_url[:sign_in_successfully]

        @can_create_more_private_app = @new_app_page.private_app_no?
        @can_create_more_private_app.should eql false
            
    end
=end
end