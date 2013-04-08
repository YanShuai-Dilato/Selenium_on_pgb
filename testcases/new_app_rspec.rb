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

describe "New an app " do
    include NewAppDialog
    include AppBriefDialog
    include BaseEnv
    include ConfigParam
    include WebdriverHelper

    before(:all) do
        init
        @base_url = base_url
        @driver = browser
        @new_app_page = NewAppPage.new(@driver)
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    end

    before(:each) do
        @dest_url = path_format_locale("/people/sign_in")
        @driver.get @dest_url
    end

    after(:each) do
        @new_app_page.close_current_browser
    end

    #
    # Create apps 
    #    by the means of uploading .zip files 
    #        by free & paid users
    #
    context "with zip file " do 
        let(:new_app_with_zip) { @new_app_page.new_app_with_zip }
        
        #
        # Scenario: 
        #     Paid user upload a zip file and create app (and this is always creating private apps)
        # Expected result: 
        #     1, The count of article tag be +1 (optional, because the max article tag count in one page is certain. )
        #     2, The newly created app's details be the same as described in the config.xml file of the .zip file.
        #
        it "upload and create successfully using paid account" do
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:paid_user][:id],@data_user[$lang][:paid_user][:password])
            sleep 5
            # @num_article_before = @driver.find_elements(:tag_name => "article").count
            # puts "Original num of article was " + @num_article.to_s
            # @new_app_page.new_app_with_zip
            @new_app_page.new_app_with_zip
            #wait_for_element_present(500,:css,"app-summary ui-block new")
            sleep 10
            # @num_article_after = @driver.find_elements(:tag_name => "article").count
            # puts "Changed num of article was " + @num_article_after.to_s
            # count should be add one after creation
            # @num_article_after.should == @num_article_before + 1
            @new_app_page.new_created_app_info.should == @new_app_page.expected_app_info_by_file
            #@driver.find_elements(:tag_name => "article").each do |option|
            #    puts option
              # option.text == value
            #end
        end

        #
        # Scenario:
        #     Free user upload a .zip file and create app
        # Expected result:
        #     1, Free user can and only can create one private app
        #
        it "upload and create successfully using free account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:free_user][:id], @data_user[$lang][:free_user][:password])
            sleep 5

            # @num_article_before = @driver.find_elements(:tag_name => "article").count
            # puts "Original num of article was " + @num_article.to_s
            @new_app_page.new_app_with_zip
            sleep 10
            # @num_article_after = @driver.find_elements(:tag_name => "article").count
            
            # count should be add one after creation
            # @num_article_after.should == @num_article_before + 1            
        end

        # For free account can create only one private app
        it "fails uploading and creating the second app using free account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:free_user][:id], @data_user[$lang][:free_user][:password])
            sleep 5
            @warning = @new_app_page.new_app_with_zip
            @warning.should == "false"
        end
    end


    # 
    # Create apps 
    #      by means of pasting github repo addresses 
    #            by free & paid users
    # 
    context "with git repo " do 
        # let(:new_public_app_with_repo) { @new_app_page.new_public_app_with_repo }
        # let(:new_private_app_with_repo) { @new_app_page.new_private_app_with_repo }

        it "upload and create public repo successfully <- using free account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:free_adobeid_02][:id],@data_user[$lang][:free_adobeid_02][:password])
            sleep 5
            @new_app_page.new_public_app_with_repo
            sleep 10
            @new_app_page.new_created_app_info.should == @new_app_page.expected_app_info_by_repo
        end
        
        it "upload and create private repo successfully <- using free account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:free_adobeid_02][:id],@data_user[$lang][:free_adobeid_02][:password])
            sleep 5
            @new_app_page.new_private_app_with_repo
            sleep 10
            @new_app_page.new_created_app_info.should == @new_app_page.expected_app_info_by_repo
        end    

        it "upload and create the second private repo should fail <- using free account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:free_adobeid_02][:id],@data_user[$lang][:free_adobeid_02][:password])
            sleep 5
            @warning = @new_app_page.new_private_app_with_repo
            @warning.should eql "false"
        end

        it "upload and create successfully <- using paid account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:paid_user][:id],@data_user[$lang][:paid_user][:password])
            sleep 5
            @new_app_page.new_public_app_with_repo
            sleep 10
            @new_app_page.new_created_app_info.should == @new_app_page.expected_app_info_by_repo
        end

        it "upload and create private repo successfully <- using paid account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:paid_user][:id],@data_user[$lang][:paid_user][:password])
            sleep 5
            @new_app_page.new_private_app_with_repo
            sleep 10
            # 
        end

        it "upload and create the 2nd private repo successfully <- using paid account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:paid_user][:id],@data_user[$lang][:paid_user][:password])
            sleep 5
            @new_app_page.new_private_app_with_repo
            @new_app_page.new_created_app_info.should == @new_app_page.expected_app_info_by_repo
        end

    end
end