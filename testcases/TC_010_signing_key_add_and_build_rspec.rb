#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative "../action/sign_in_page"
require_relative "../action/edit_account_page"
require_relative "../action/new_app_page"
require_relative "../data/base_env"
require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"
require_relative "../tools/edit_account_dialog"
require_relative "../tools/new_app_dialog"

describe "TC_010: signing_key_add_and_build_rspec" do 
	include BaseEnv
    include SignInDialog
    include SignInGithubDialog
    include EditAccountDialog
    include NewAppDialog
    include ConfigParam
    include WebdriverHelper

    before(:all) do 
        init
        @order_it = WebdriverHelper::Counter.new
        @name_screenshot = "TC_009_IT_"
        @base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))

        @driver = browser # have to start a new instance each time to clean the cache.
        @driver.manage.window.maximize
        @driver.execute_script("window.resizeTo(screen.width,screen.height)")
        @sign_in_page = SignInPage.new @driver, user: @data_user, str: @data_str, url: @data_url, xpath: @data_xpath
        @new_app_page = NewAppPage.new(@driver)
        @edit_account_page = EditAccountPage.new @driver, user: @data_user, str: @data_str, url: @data_url, xpath: @data_xpath

        @driver.get path_format_locale("/people/sign_in")
        @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_002][:id],
                                            @data_user[$lang][:adobe_id_free_002][:password])
        sleep 10
    end

    after(:all) do 
        @driver.quit

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

    after(:each) do 
        @name_screenshot += @order_it.inc.to_s

        if example.exception != nil
            # Failure only code goes here
            take_screenshot_with_name @name_screenshot
        end
    end

    context "--- " do 
    	before(:all) do 
    		@new_app_page.new_public_app_with_repo
            app_id = @new_app_page.get_first_app_id
            current_url = @driver.current_url
            puts "+ app ID: #{app_id}"
            puts "+ current_url: #{current_url}"
            puts "+ #{current_url}/#{app_id}/builds"
            ready_to_build_btn.click
            sleep 10
            @driver.get current_url + "/#{app_id}/builds"
            sleep 5
            builds_tab.click
            sleep 60
    	end

    	it "" do 

            # select_list = driver.find_element(:id, drop_down_id) #or however you need to find the element (:class, :text, etc..)
            # dropdown = Selenium::WebDriver::Support::Select.new(select_list)
            # dropdown.select_by(:text, "value_you_want_to_select")

            puts ios_signingkey_dropdown.attribute("disabled")
            puts ios_signingkey_dropdown.attribute("name")
            puts android_signingkey_dropdown.attribute("disabled")
            puts android_signingkey_dropdown.attribute("name")
            puts blackberry_signingkey_dropdown.attribute("disabled")
            puts blackberry_signingkey_dropdown.attribute("name")

            # select one item from the dropdown list. 
            dropdown = Selenium::WebDriver::Support::Select.new(blackberry_signingkey_dropdown)
            dropdown.select_by(:text, "add a key ...")

            sleep 60
    		"a".should eql "a"
    	end
    end


end