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

describe "" do 
  include BaseEnv
  include ConfigParam
  include WebdriverHelper
  include HeaderDialog
  include EditAccountDialog
  include RegisterDialog

  before(:all) do 
    init
    @order_of_it = WebdriverHelper::Counter.new
    @name_screenshot = "TC_015_IT_"
    @base_url = base_url
    @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
    @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
    @data_plugin = YAML::load(File.read(File.expand_path("../../data/data_plugin.yml",__FILE__)))
    @driver = browser 
    @driver.manage.window.maximize
    @driver.execute_script("window.resizeTo(screen.width,screen.height)")
    @sign_in_page = SignInPage.new @driver, xpath: @data_xpath, url: @data_url, user: @data_user
    @driver.get path_format_locale("/people/sign_in")  
    @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_002][:id],
                                        @data_user[$lang][:adobe_id_free_002][:password])
  end

  after(:all) do 
    @driver.quit
  end

  describe "Private code hosting" do 

    it "IT_001: should change the username and ssh_key successfully" do 

      go_to_page_edit_account
      private_code_hosting_tab.click

      user_name = @data_user[$lang][:private_code_hosting][:user_name]
      user_ssh_key = @data_user[$lang][:private_code_hosting][:user_ssh_key]
      
      pch(:person_username_text).clear
      pch(:person_username_text).send_keys(user_name)
      pch(:person_ssh_key_text).clear
      pch(:person_ssh_key_text).send_keys(user_ssh_key)
      pch(:save_btn).click
      sleep 5

      @driver.current_url.should =~ /http:\/\/loc.build.phonegap.com\/apps/

      go_to_page_edit_account
      private_code_hosting_tab.click
      
      pch(:person_username_text).attribute('value').should eql user_name
      pch(:person_ssh_key_text).text.should eql user_ssh_key
    end
  end

end