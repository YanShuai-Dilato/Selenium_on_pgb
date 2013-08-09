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
require_relative "../tools/register_dialog"

describe "TC_014: User sign in/out and account delete" do 
  include BaseEnv
  include ConfigParam
  include WebdriverHelper
  include HeaderDialog
  include EditAccountDialog
  include RegisterDialog

  before(:all) do 
    init
    @order_of_it = WebdriverHelper::Counter.new
    @name_screenshot = "TC_014_IT_"
    @base_url = base_url
    @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
    @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
    @data_plugin = YAML::load(File.read(File.expand_path("../../data/data_plugin.yml",__FILE__)))
    @driver = browser 
    @driver.manage.window.maximize
    @driver.execute_script("window.resizeTo(screen.width,screen.height)")
    @sign_in_page = SignInPage.new @driver, xpath: @data_xpath, url: @data_url, user: @data_user
  end

  after(:all) do 
    @driver.quit
  end

  # User sign in/out: done! 
  describe "User sign in/out" do 

    it "IT_001: should sign-in successfully" do 

      @driver.get path_format_locale("/people/sign_in")  
      @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_002][:id],
                                          @data_user[$lang][:adobe_id_free_002][:password])
      @driver.current_url.should =~ /http:\/\/loc.build.phonegap.com\/apps/
    end

    it "IT_002: should sign out successfully" do 
      
      sign_out # header_dialog.rb
      @driver.current_url.should =~ /http:\/\/loc.build.phonegap.com\//
      account_notice.text.should eql @data_str[$lang][:user_signout_notice]
    end
  end

  describe "Danger Zone" do  # Delete my account

    before do 
      @driver.get path_format_locale("/people/sign_in") 
      @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_002][:id],
                                          @data_user[$lang][:adobe_id_free_002][:password])
      sleep 5 
    end

    after do  # recover the deleted account
      @driver.get path_format_locale("/plans/free-adobeid") 
      @driver.switch_to.frame(0)
      adobe_id_frame_enter_email(@data_user[$lang][:adobe_id_free_002][:id])
      adobe_id_frame_enter_password(@data_user[$lang][:adobe_id_free_002][:password])
      adobe_id_frame_sign_in_btn.click
      sleep 10
    end

    # Delete-account: done!
    it "IT_007: should match to localized 'account-delete-notice'" do 

      go_to_page_edit_account
      account_details_tab.click     
      ad_delete_account()

      @driver.current_url.should =~ /http:\/\/loc.build.phonegap.com\//
      ad_account_deleted_notice.text.should eql @data_str[$lang][:account_deleted_notice]
    end
  end

end