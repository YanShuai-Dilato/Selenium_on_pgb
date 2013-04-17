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

describe "New an app with free account" do
    include NewAppDialog
    include AppBriefDialog
    include BaseEnv
    include ConfigParam
    include WebdriverHelper

    before(:all) do
        puts "before all outer"
        init
        @base_url = base_url
        @new_app_page = nil
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    end

    after(:all) do 
        # delete all apps
        private_resource = RestClient::Resource.new 'http://loc.build.phonegap.com/api/v1/apps' , {:user => @data_user[$lang][:adobe_id_free_002][:id] , :password => @data_user[$lang][:adobe_id_free_002][:password] , :timeout => 30}
        response = private_resource.get :accept => :json
        json =  JSON.parse(response)
        json['apps'].each do |i|
            #puts i['link']
            url = @base_url + i['link']
            private_resource = RestClient::Resource.new url , {:user => @data_user[$lang][:adobe_id_free_002][:id] , :password => @data_user[$lang][:adobe_id_free_002][:password] , :timeout => 30}
            response = private_resource.delete 
            # puts response.to_str
        end
    end
   
   # this context need at least one public app to start with. 
    context "- with Adobe ID - free account" do 
        before(:all) do 
            puts "before all inside"
            @base_url = base_url
            @driver = browser
            @new_app_page = NewAppPage.new(@driver)
            @driver.get path_format_locale("/people/sign_in")
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_002][:id],
                                                          @data_user[$lang][:adobe_id_free_002][:password])
            sleep 5
        end

        after(:all) do 
            @new_app_page.close_current_browser
        end

    	it "#Tip: paste .git repo" do 
            textbox_paste_a_git_repo.attribute('placeholder').to_s.should eql @data_str[$lang][:PGB_paste_git_repo]
    	end

    	it "#Tip: Connect your Github account" do 
            link_connect_your_github_account.text.should eql @data_str[$lang][:PGB_connect_your_github_account] # why waiting that much time
    	end

    	it "#errors when pasting a invalid .git address" do 
            @warning = @new_app_page.paste_a_git_repo("abcd")
            @warning.should eql @data_str[$lang][:PGB_not_a_valid_github_url]
    	end

    	it "create an opensource app by pasting a .git" do 
            @driver.navigate.refresh
            sleep 5
            
            @new_app_page.new_public_app_with_repo
            sleep 5
            # walk round
            @driver.navigate.refresh
            sleep 5 
            
            @app_count_after = @new_app_page.get_existing_app_num
            @first_app_id_after = @new_app_page.get_first_app_id
            puts "+app_count_after: #{@app_count_after}"
            puts "+first_app_id_after: #{@first_app_id_after}"
 
            @first_app_id_after.should_not eql @first_app_id_before
            @app_count_after.should_not eql @app_count_before 
    	end

    	it "create the first private app by uploading a .zip file" do 
            @driver.navigate.refresh
            sleep 5
            @app_count_before = @new_app_page.get_existing_app_num
            @first_app_id_before = @new_app_page.get_first_app_id
            puts "+app_count_before: #{@app_count_before}"
            puts "+first_app_id_before: #{@first_app_id_before}"

            @new_app_page.new_app_with_zip

            @driver.navigate.refresh
            sleep 5 
            
            @app_count_after = @new_app_page.get_existing_app_num
            @first_app_id_after = @new_app_page.get_first_app_id
            puts "+app_count_after: #{@app_count_after}"
            puts "+first_app_id_after: #{@first_app_id_after}"

            @app_count_after.should_not eql @app_count_before 
            @first_app_id_after.should_not eql @first_app_id_before
    	end

    	it "can not create another private app"  do 
            @app_count_before = @new_app_page.get_existing_app_num
            @first_app_id_before = @new_app_page.get_first_app_id
            puts "+app_count_before: #{@app_count_before}"
            puts "+first_app_id_before: #{@first_app_id_before}"

            @return_value = @new_app_page.new_app_with_zip # button & select disabled. 
           
            if (!@return_value) 
                @app_count_after = @new_app_page.get_existing_app_num
                @first_app_id_after = @new_app_page.get_first_app_id
                puts "+app_count_after: #{@app_count_after}"
                puts "+first_app_id_after: #{@first_app_id_after}"
            end

            @return_value.should eql false
    	end
    end

    context "- with Adobe ID - free account - connected github" do 
        before(:all) do 
            puts "before all inside"
            @base_url = base_url
            @driver = browser
            @new_app_page = NewAppPage.new(@driver)
            @driver.get path_format_locale("/people/sign_in")
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_connected_github_001][:id],
                                                          @data_user[$lang][:adobe_id_free_connected_github_001][:password])
            sleep 5
        end

        after(:all) do 
            @new_app_page.close_current_browser
        end

        it "#Dropdown list of existing repo" do 
            if @new_app_page.new_btn_exists? 
                new_app_btn.click 
            end 
            @driver.find_element(:xpath => "/html/body/section/div/div/div/form/div[2]/div/div/span[2]").click
            sleep 3
            @li = @driver.find_elements(:xpath => "//*[@id='new-app']/form/div[2]/div[1]/div/ul/li")
            @li_count = @li.count
            puts "+li count: #{@li_count}"
            @li_count.should_not eql 0    
        end

        it "#Tip: find existing repo / paste .git repo" do 
            if @new_app_page.new_btn_exists? 
                puts "+new_btn_exists"
                # new_app_btn.click 
            end 
            textbox_paste_a_git_repo.attribute('placeholder').to_s.should eql @data_str[$lang][:PGB_find_existing_repo_or_paste_git_repo]
        end

        it "#errors when pasting a invalid .git address" do 
            @warning = @new_app_page.paste_a_git_repo("亜印gっをげwにwpw声wんw儀栄wペイ儀絵印rgる")
            @warning.should eql @data_str[$lang][:PGB_not_a_valid_github_url]
        end

        it "match some apps in the list if enter some letters" do 
            textbox_paste_a_git_repo.send_keys("sa")
            @the_first_item = @driver.find_element(:xpath => "//*[@id='new-app']/form/div[2]/div[1]/div/ul/li")
            puts "The first matched item: #{@the_first_item.text}"
            @the_first_item.text.should eql @data_str[$lang][:PGB_the_first_matched_item] 
            sleep 5
            # count the number
        end

        it "match no apps in the list if enter some specific letters" do 
            textbox_paste_a_git_repo.clear
            textbox_paste_a_git_repo.send_keys("sss")
            @the_first_item = @driver.find_element(:xpath => "//*[@id='new-app']/form/div[2]/div[1]/div/ul/li")
            puts "The first item: #{@the_first_item.text}"
            @the_first_item.text.should eql @data_str[$lang][:PGB_no_match_item]
        end

        it "Select a repo from the matched items to create an app" do 
            @app_count_before = @new_app_page.get_existing_app_num
            @first_app_id_before = @new_app_page.get_first_app_id
            puts "+app_count_before: #{@app_count_before}"
            puts "+first_app_id_before: #{@first_app_id_before}"

            textbox_paste_a_git_repo.clear
            textbox_paste_a_git_repo.send_keys("sa")
            @the_first_item = @driver.find_element(:xpath => "//*[@id='new-app']/form/div[2]/div[1]/div/ul/li")
            @the_first_item.click
            sleep 5

            @driver.navigate.refresh
            sleep 5 
            @app_count_after = @new_app_page.get_existing_app_num
            @first_app_id_after = @new_app_page.get_first_app_id
            puts "+app_count_after: #{@app_count_after}"
            puts "+first_app_id_after: #{@first_app_id_after}"

        end

    end


end
