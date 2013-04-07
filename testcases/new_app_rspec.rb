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
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
        # wait_for_element_present(5, :xpath, new_app_btn)
    end

    before(:each) do
        @driver = browser
        @new_app_page = NewAppPage.new(@driver)
        @driver.get path_format_locale("/people/sign_in")
    end

    after(:each) do
        @new_app_page.close_current_browser
    end
=begin
    context "with zip file " do 
        let(:new_app_with_zip) { @new_app_page.new_app_with_zip }
        
        it "upload and create successfully using paid account" do
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:paid_user][:id],@data_user[$lang][:paid_user][:password])
            sleep 5

            @num_article_before = @driver.find_elements(:tag_name => "article").count
            # puts "Original num of article was " + @num_article.to_s
            # @new_app_page.new_app_with_zip
            new_app_with_zip
            #wait_for_element_present(500,:css,"app-summary ui-block new")
            sleep 10
            @num_article_after = @driver.find_elements(:tag_name => "article").count
            puts "Changed num of article was " + @num_article_after.to_s
            # count should be add one after creation
            @num_article_after.should == @num_article_before + 1

            #@driver.find_elements(:tag_name => "article").each do |option|
            #    puts option
              # option.text == value
            #end
        end

        it "upload and create successfully using free account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:free_user][:id], @data_user[$lang][:free_user][:password])
            sleep 5

            @num_article_before = @driver.find_elements(:tag_name => "article").count
            # puts "Original num of article was " + @num_article.to_s
            new_app_with_zip
            sleep 10
            @num_article_after = @driver.find_elements(:tag_name => "article").count
            
            # count should be add one after creation
            @num_article_after.should == @num_article_before + 1            
        end

        # For free account can create only one private app
        it "fails uploading and creating the second app using free account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:free_user][:id], @data_user[$lang][:free_user][:password])
            sleep 5
            create_the_second_app_free_account.should be_false
        end
    end
=end
    context "with git repo " do 
        let(:new_app_with_pub_repo) { @new_app_page.new_app_with_pub_repo }

        it "upload and create successfully using free account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:free_adobeid][:id],@data_user[$lang][:free_adobeid][:password])
            sleep 5
            # @num_article_before = article_tags_on_page.count
            @id_top_before = id_of_app.text
            puts @id_top_before

            new_app_with_pub_repo
            sleep 10

            # @num_article_after = article_tags_on_page.count
            @id_top_after = id_of_app.text
            puts @id_top_after
            
            id_top_before.to_i.should_not eql id_top_after.to_i
            
            
            
            #source_of_app.should == @app_data[:new_app][:by_repo]
            # count should be add one after creation
            # @num_article_after.should == @num_article_before + 1
        end

        it "upload and create successfully using paid account" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:paid_user][:id],@data_user[$lang][:paid_user][:password])
            sleep 5

            @id_top_before = id_of_app.text
            new_app_with_pub_repo
            sleep 10

            @id_top_after = id_of_app

            @id_top_after.to_i.should_not eql id_top_after.to_i

        end
    end

end