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
        @num_private_app = 0
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
        if @num_private_app >= 10  # then delete all apps, as is know that the max number is 24 for 9.99/m account
            puts "Current number of private app was #{@num_private_app}"
            private_resource = RestClient::Resource.new 'http://loc.build.phonegap.com/api/v1/apps' , {:user => @data_user[$lang][:adobe_id_free_002][:id] , :password => @data_user[$lang][:adobe_id_free_002][:password] , :timeout => 30}
            response = private_resource.get :accept => :json
            json =  JSON.parse(response)
            json['apps'].each do |i|
                url = @base_url + i['link']
                private_resource = RestClient::Resource.new url , {:user => @data_user[$lang][:adobe_id_free_002][:id] , :password => @data_user[$lang][:adobe_id_free_002][:password] , :timeout => 30}
                response = private_resource.delete 
                puts response.to_str
            end
        end
    end

    it "create the first private app by uploading a .zip file" do 
        @new_app_page.new_app_with_zip

        # @driver.navigate.refresh
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
        
        # @driver.navigate.refresh
        sleep 5 

        @app_count_after = @new_app_page.get_existing_app_num
        @num_private_app = @app_count_after
        @first_app_id_after = @new_app_page.get_first_app_id
        puts "+app_count_after: #{@app_count_after}"
        puts "+first_app_id_after: #{@first_app_id_after}"
        
        @first_app_id_after.should_not eql @first_app_id_before
    end    

end
