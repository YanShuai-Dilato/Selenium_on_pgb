require 'rspec'
require 'rubygems'
require 'selenium-webdriver'

require_relative "../action/sign_in_page"
require_relative "../action/new_app_page"
require_relative "../tools/new_app_dialog"
require_relative "../tools/app_brief_dialog"
require_relative "../data/base_env"
require_relative "../lib/config_param"

describe "Create an app " do
    include NewAppDialog
    include BaseEnv
    include AppBriefDialog
    include ConfigParam

    before(:all) do
        init
        @url = base_url + "/people/sign_in"
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @app_data = YAML::load(File.read(File.expand_path("../../data/data_app.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
    end

    before(:each) do
        @driver = browser
        @new_app_page = NewAppPage.new(@driver)
        @driver.get @url
    end

    after(:each) do
        @new_app_page.close_current_browser
    end
=begin
    describe "-> by zip file " do 
        it "should work successfully" do
            @num_article = @driver.find_elements(:tag_name => "article").count
            # puts "Original num of article was " + @num_article.to_s
            @new_app_page.new_app_with_zip
            wait_for_element_present(500,:css,"app-summary ui-block new")
            @num_article_after = @driver.find_elements(:tag_name => "article").count
            puts "Changed num of article was " + @num_article_after.to_s

            @num_article_after.should == @num_article + 1

            #@driver.find_elements(:tag_name => "article").each do |option|
            #    puts option
              # option.text == value
            #end
        end
    end
=end
    # Pass
    describe "-> by git repo " do 

        it "should work successfully" do 
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[:en_us][:free_adobeid][:id],@data_user[:en_us][:free_adobeid][:password])
            sleep 5
            @num_article_before = @driver.find_elements(:tag_name => "article").count
            @new_app_page.new_app_with_pub_repo
            sleep 10
            @num_article_after = @driver.find_elements(:tag_name => "article").count

            source_of_app_by_repo.should == @app_data[:new_app][:by_repo]
            @num_article_after.should == @num_article_before + 1
        end
    end

end