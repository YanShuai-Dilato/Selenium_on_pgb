require 'rspec'
require 'rubygems'
require 'selenium-webdriver'

# $:.unshift File.join(File.dirname(__FILE__),"..")

require_relative "../action/sign_in_page"
require_relative "../action/new_app_page"
require_relative "../tools/new_app_dialog"
require_relative "../data/base_env"

describe "Create an app " do
    include NewAppDialog
    include BaseEnv

    before(:all) do
        @driver = browser
        @url = base_url + "/people/sign_in"
        @driver.get @url
        @data_xpath = YAML::load(File.read("../data/data_xpath.yml"))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[:en_us][:free_adobeid][:id],@data_user[:en_us][:free_adobeid][:password])
        sleep 5
        # wait_for_element_present(5, :xpath, new_app_btn)
    end

    before(:each) do
        @click_element = NewAppPage.new(@driver)
    end

    after(:each) do
        @click_element.close_current_browser
    end

    describe "-> by zip file " do 
        it "should work successfully" do
            @num_article = @driver.find_elements(:tag_name => "article").count
            # puts "Original num of article was " + @num_article.to_s
            @click_element.new_app_with_zip
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
=begin
    # Pass
    describe "-> by git repo " do 
        it "should work successfully" do 
            #@driver = browser
            @num_article = @driver.find_elements(:tag_name => "article").count
            @click_element.new_app_with_pub_repo
            @num_article_after = @driver.find_elements(:tag_name => "article").count
            @num_article_after.should == @num_article + 1
        end
    end
=end
end