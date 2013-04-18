#encoding: utf-8

require 'rspec'
require 'rubygems'
require 'selenium-webdriver'
require 'yaml'

require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"
require_relative "../action/sign_in_page"
require_relative "../action/new_app_page"
require_relative "../tools/new_app_dialog"
require_relative "../tools/app_brief_dialog"
require_relative "../data/base_env"


describe "New apps with paid account" do
    include NewAppDialog
    include AppBriefDialog
    include BaseEnv
    include ConfigParam
    include WebdriverHelper

    before(:all) do
        init
        @base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))

        @driver = browser
        @new_app_page = NewAppPage.new(@driver)
        @driver.get path_format_locale("/people/sign_in")
        SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:adobe_id_paid_001][:id],
                                                      @data_user[$lang][:adobe_id_paid_001][:password])
        sleep 5
    end

    after(:all) do
        @new_app_page.close_current_browser
    end

    it "create the first private app by uploading a .zip file" do 
        @new_app_page.new_app_with_zip

        @driver.navigate.refresh
        sleep 5 
            
        @app_count_after = @new_app_page.get_existing_app_num
        @first_app_id_after = @new_app_page.get_first_app_id
        puts "+app_count_after: #{@app_count_after}"
        puts "+first_app_id_after: #{@first_app_id_after}"
 
        @app_count_after.should_not eql 0
    end

    it "create the second private app successfully"  do 
        sleep 5
        @app_count_before = @new_app_page.get_existing_app_num
        @first_app_id_before = @new_app_page.get_first_app_id
        puts "+app_count_before: #{@app_count_before}"
        puts "+first_app_id_before: #{@first_app_id_before}"

        @return_value = @new_app_page.new_app_with_zip  
        
        @driver.navigate.refresh
        sleep 5 

        @app_count_after = @new_app_page.get_existing_app_num
        @first_app_id_after = @new_app_page.get_first_app_id
        puts "+app_count_after: #{@app_count_after}"
        puts "+first_app_id_after: #{@first_app_id_after}"
        
        @first_app_id_after.should_not eql @first_app_id_before
    end    

end
