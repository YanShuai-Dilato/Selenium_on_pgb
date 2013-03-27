require 'rspec'
require 'rubygems'
require 'selenium-webdriver'

# $:.unshift File.join(File.dirname(__FILE__),"..")

require_relative "../action/sign_in_page"
require_relative "../action/new_app_page"
require_relative "../tools/new_app_dialog"
require_relative "../data/base_env"
require_relative "../lib/app_detail_verify"

describe "Create an app " do
    include NewAppDialog
    include BaseEnv
    include AppDetailVerify

    before(:all) do
        @driver = browser
        @url = base_url + "/people/sign_in"
        @driver.get @url
        @data_xpath = YAML::load(File.read("../data/data_xpath.yml"))
        @app_data = YAML::load(File.read("../data/data_app.yml"))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[:en_us][:free_adobeid][:id],@data_user[:en_us][:free_adobeid][:password])
        sleep 5
        # wait_for_element_present(5, :xpath, new_app_btn)
    end

    before(:each) do
        @new_app_page = NewAppPage.new(@driver)
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
            @new_app_page.new_app_with_pub_repo
            source_of_app_by_repo.should == @app_data[:new_app][:by_repo]
        end
    end

end