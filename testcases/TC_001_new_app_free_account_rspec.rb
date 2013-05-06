#encoding: utf-8

require 'rspec'
require 'rubygems'
require 'selenium-webdriver'
require 'yaml'
require 'rest_client'
require 'json'

require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"
require_relative "../action/sign_in_page"
require_relative "../action/new_app_page"
require_relative "../tools/new_app_dialog"
require_relative "../tools/app_brief_dialog"
require_relative "../data/base_env"

# This TC describes 
#   situations when try to create app(s) using free account(Adobe ID & Github-connected Adobe ID)
describe "TC_001: New an app with free account" do
    include BaseEnv
    include ConfigParam
    include WebdriverHelper
    include NewAppDialog
    include AppBriefDialog

    before(:all) do
        puts "+ before all outer"
        init
        @order_it = WebdriverHelper::Counter.new
        @name_screenshot = "TC_001_IT_"
        @base_url = base_url
        @data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url ||= YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user ||= YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str ||= YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    end

    # Try to delete all new-created apps 
    # to make sure it be a clean run the next time. 
    after(:all) do 
        private_resource = RestClient::Resource.new 'http://loc.build.phonegap.com/api/v1/apps' , {:user => @data_user[$lang][:adobe_id_free_002][:id] , :password => @data_user[$lang][:adobe_id_free_002][:password] , :timeout => 30}
        response = private_resource.get :accept => :json
        json =  JSON.parse(response)
        json['apps'].each do |i|
            url = @base_url + i['link']
            private_resource = RestClient::Resource.new url , {:user => @data_user[$lang][:adobe_id_free_002][:id] , :password => @data_user[$lang][:adobe_id_free_002][:password] , :timeout => 30}
            response = private_resource.delete 
            puts response.to_str
        end

        private_resource_2 = RestClient::Resource.new 'http://loc.build.phonegap.com/api/v1/apps' , {:user => @data_user[$lang][:adobe_id_free_connected_github][:id] , :password => @data_user[$lang][:adobe_id_free_connected_github][:password] , :timeout => 30}
        response_2 = private_resource_2.get :accept => :json
        json_2 =  JSON.parse(response_2)
        json_2['apps'].each do |i|
            url = @base_url + i['link']
            private_resource_2 = RestClient::Resource.new url , {:user => @data_user[$lang][:adobe_id_free_connected_github][:id] , :password => @data_user[$lang][:adobe_id_free_connected_github][:password] , :timeout => 30}
            response_2 = private_resource_2.delete 
            puts response_2.to_str
        end
    end

    after(:each) do 
        
        @name_screenshot += @order_it.inc.to_s
        if example.exception != nil  # Take screenshot when failure happens. 
            take_screenshot_with_name @name_screenshot
        end

    end

    # This context describes that 
    #   situations trying to create app(s) using Adobe ID(free). 
    context "--- with Adobe ID - free account" do 
        before(:all) do 
            puts "+ before all inside"
            @base_url = base_url
            @driver = browser
            @driver.manage.window.maximize
            @new_app_page = NewAppPage.new(@driver)
            @driver.get path_format_locale("/people/sign_in")
            @sign_in_page = SignInPage.new @driver, xpath: @data_xpath, url: @data_url, str: @data_str, user: @data_user
            @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_002][:id],
                                                @data_user[$lang][:adobe_id_free_002][:password])
            # wait_for_element_present(60, :xpath, @data_xpath[:sign_in_succ_page][:new_app_btn])
            sleep 10
        end

        after(:all) do 
            @driver.quit
        end

    	it "IT_001: #Tip: paste .git repo" do 
            if @new_app_page.new_app_btn_display? 
                new_app_btn.click
                puts "+ new_app_btn.click"
            end
            paste_git_repo_input.attribute('placeholder').should eql @data_str[$lang][:PGB_paste_git_repo]
    	end

    	it "IT_002: #Tip: Connect your Github account" do   
            link_connect_your_github_account.text.should eql @data_str[$lang][:PGB_connect_your_github_account]
    	end

    	it "IT_003: #errors when pasting a invalid .git address" do    
            @warning = @new_app_page.paste_a_git_repo("abcd")
            @warning.should eql @data_str[$lang][:PGB_not_a_valid_github_url]
    	end

    	it "IT_004: create an opensource app by pasting a .git" do  
            puts "+ before @new_app_page.new_public_app_with_repo"

            @new_app_page.new_public_app_with_repo

            app_count_after = @new_app_page.get_existing_app_num
            first_app_id_after = @new_app_page.get_first_app_id
            puts "+ app_count_after: #{app_count_after}"
            puts "+ first_app_id_after: #{first_app_id_after}"
 
            app_count_after.should eql 1 

    	end

    	it "IT_005: Create the first private app by uploading a .zip file" do 
            @driver.navigate.refresh
            sleep 10

            app_count_before = @new_app_page.get_existing_app_num
            first_app_id_before = @new_app_page.get_first_app_id
            puts "+ app_count_before: #{app_count_before}"
            puts "+ first_app_id_before: #{first_app_id_before}"

            @new_app_page.new_app_with_zip
          
            app_count_after = @new_app_page.get_existing_app_num
            first_app_id_after = @new_app_page.get_first_app_id
            puts "+ app_count_after: #{app_count_after}"
            puts "+ first_app_id_after: #{first_app_id_after}"

            app_count_after.should_not eql @app_count_before 
            first_app_id_after.should_not eql @first_app_id_before
    	end

    	it "IT_006: Can not create another private app"  do 
            # @driver.navigate.refresh
            sleep 10

            app_count_before = @new_app_page.get_existing_app_num
            first_app_id_before = @new_app_page.get_first_app_id
            puts "+ app_count_before: #{app_count_before}"
            puts "+ first_app_id_before: #{first_app_id_before}"

            return_value = @new_app_page.new_app_with_zip 
           
            if (!return_value) 
                app_count_after = @new_app_page.get_existing_app_num
                first_app_id_after = @new_app_page.get_first_app_id
                puts "+ app_count_after: #{app_count_after}"
                puts "+ first_app_id_after: #{first_app_id_after}"
                puts "+ You will not see me"
            end

            return_value.should eql false
    	end

    end

    # This context describes that 
    #   situations trying to create app(s) using Adobe ID(free), which is connected Github
    context "--- with Adobe ID - free account - connected github" do 
        before(:all) do 
            puts "before all inside"
            @base_url = base_url
            @driver = browser
            @driver.manage.window.maximize
            @new_app_page = NewAppPage.new(@driver)
            @driver.get path_format_locale("/people/sign_in")
            @sign_in_page = SignInPage.new @driver, xpath: @data_xpath, url: @data_url, str: @data_str, user: @data_user
            @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_connected_github][:id],
                                                @data_user[$lang][:adobe_id_free_connected_github][:password])
            sleep 10
        end

        after(:all) do 
            @driver.quit
        end

        it "IT_007_#Dropdown list of existing repo" do 
            if @new_app_page.new_app_btn_display? 
                new_app_btn.click
                puts "new_app_btn.click"
            end
            @driver.find_element(:xpath => "/html/body/section/div/div/div/form/div[2]/div/div/span[2]").click
            sleep 3
            li = @driver.find_elements(:xpath => "//*[@id='new-app']/form/div[2]/div[1]/div/ul/li")
            li_count = li.count
            puts "+li count: #{li_count}"
            li_count.should_not eql 0    
        end

        it "IT_008_#Tip: find existing repo / paste .git repo" do 
            if @new_app_page.new_app_btn_display? 
                new_app_btn.click
                puts "new_app_btn.click"
            end
            paste_git_repo_input.attribute('placeholder').to_s.should eql @data_str[$lang][:PGB_find_existing_repo_or_paste_git_repo]
        end

        it "IT_009_#errors when pasting a invalid .git address" do 
            if @new_app_page.new_app_btn_display? 
                new_app_btn.click
                puts "new_app_btn.click"
            end
            warning = @new_app_page.paste_a_git_repo("亜印gっをげwにwpw声wんw儀栄wペイ儀絵印rgる")
            warning.should eql @data_str[$lang][:PGB_not_a_valid_github_url]
        end

        it "IT_010_match some apps in the list if enter some letters" do 
            if @new_app_page.new_app_btn_display? 
                new_app_btn.click
                puts "new_app_btn.click"
            end
            paste_git_repo_input.send_keys("sa")
            the_first_item = @driver.find_element(:xpath => "//*[@id='new-app']/form/div[2]/div[1]/div/ul/li")
            puts "The first matched item: #{the_first_item.text}"
            the_first_item.text.should eql @data_str[$lang][:PGB_the_first_matched_item] 
        end

        it "IT_011_match no apps in the list if enter some specific letters" do 
            if @new_app_page.new_app_btn_display? 
                new_app_btn.click
                puts "new_app_btn.click"
            end
            paste_git_repo_input.clear
            paste_git_repo_input.send_keys("sss")
            the_first_item = @driver.find_element(:xpath => "//*[@id='new-app']/form/div[2]/div[1]/div/ul/li")
            puts "The first item: #{the_first_item.text}"
            the_first_item.text.should eql @data_str[$lang][:PGB_no_match_item]
        end

        it "IT_012_Select a repo from the matched items to create an app" do  
            if @new_app_page.new_app_btn_display? 
                new_app_btn.click
                puts "new_app_btn.click"
            end        
            paste_git_repo_input.clear
            paste_git_repo_input.send_keys("start")
            the_first_item = @driver.find_element(:xpath => "//*[@id='new-app']/form/div[2]/div[1]/div/ul/li")
            the_first_item.click
            sleep 5

            wait_for_element_present(60, :xpath, @data_xpath[:sign_in_succ_page][:first_app_id])

            app_count_after = @new_app_page.get_existing_app_num
            first_app_id_after = @new_app_page.get_first_app_id
            puts "+app_count_after: #{app_count_after}"
            puts "+first_app_id_after: #{first_app_id_after}"

            @app_count_after.should_not eql 0
        end
    end

end
