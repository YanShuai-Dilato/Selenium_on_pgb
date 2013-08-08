#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'yaml'
require 'selenium-webdriver'

require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"
require_relative "../action/sign_in_page"
require_relative "../data/base_env"
require_relative "../tools/header_dialog"
require_relative "../tools/edit_account_dialog"
require_relative "../tools/sign_in_github_dialog.rb"

describe "TC_013: 'Account details' page" do 
  include BaseEnv
  include ConfigParam
  include WebdriverHelper
  include HeaderDialog
  include EditAccountDialog
  include SignInGithubDialog

  before(:all) do 
    init
    @order_of_it = WebdriverHelper::Counter.new
    @name_screenshot = "TC_013_IT_"
    @base_url = "https://buildstage.phonegap.com"
    @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
    @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
    @data_plugin = YAML::load(File.read(File.expand_path("../../data/data_plugin.yml",__FILE__)))
    @driver = browser 
    @driver.manage.window.maximize
    @driver.execute_script("window.resizeTo(screen.width,screen.height)")

    @driver.get path_format_locale(@base_url,"/people/sign_in") 
    @sign_in_page = SignInPage.new @driver, xpath: @data_xpath, url: @data_url, user: @data_user
    @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_002][:id],
                                        @data_user[$lang][:adobe_id_free_002][:password])
  end

  after(:all) do 
    @driver.quit
  end

  after(:each) do  # Take screenshot in case of failure
    @name_screenshot += @order_of_it.inc.to_s

    if example.exception != nil
      take_screenshot_with_name @name_screenshot
    end
  end

  describe "Link/Unlink Github account" do 

    before do 
      go_to_page_edit_account
      account_details_tab.click
    end

    it "IT_001: should link to 'http://www.adobe.com/account.html' page" do 

      ad_manage_your_adobe_id_link.attribute('href').should eql "http://www.adobe.com/account.html"
    end

    it "IT_002: should link Github account successfully" do 
      
      ad_connect_a_github_id_btn.click
      enter_github_account_and_sign_in_with(@data_user[$lang][:adobe_id_free_002])
      sleep 5
      @driver.current_url.should =~ /https:\/\/buildstage.phonegap.com\/people\/edit/
      ad_notification.text.should eql @data_str[$lang][:edit_account_connect_github_account_successfully]
    end

    it "IT_003: should link to 'https://github.com/settings/applications' page" do 

      ad_manage_your_github_account_link.attribute('href').should eql "https://github.com/settings/applications"
    end

    it "IT_004: should unlink the Github account successfully" do 

      ad_unlink_github_id_btn.click
      a = @driver.switch_to.alert
      a.accept
      sleep 10
      puts ad_connect_a_github_id_btn.to_s.should_not eql nil
    end
  end

  # Token-feature: done! 
  describe "Authentication Tokens" do  # create/reset/delete token

    before do 
      go_to_page_edit_account
      account_details_tab.click
      @current_token = nil
    end

    it "IT_005: should be 'no token' at first" do 

      @current_token = ad_token_text.attribute('value')
      @current_token.should eql @data_str[$lang][:ad_no_token]
    end

    it "IT_006: should be a different token after creating one" do 

      ad_token_create_reset_btn.click
      @current_token = ad_token_text.attribute('value')
      @current_token.should_not eql @data_str[$lang][:ad_no_token]
    end

    it "IT_007: should be a different from the last one after reseting" do 

      token_before = @current_token
      ad_token_create_reset_btn.click
      @current_token = ad_token_text.attribute('value')
      @current_token.should_not eql token_before
    end

    it "IT_008: should be 'no token' after deleting it" do 

      ad_token_delete_btn.click
      @current_token = ad_token_text.attribute('value')
      @current_token.should eql @data_str[$lang][:ad_no_token]
    end
  end
  
end