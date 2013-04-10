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


describe "New an app with free account" do
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

    context "Account not connected to github" do 
    	it "does not have a dropdown app-list" do 

    	end

    	it "#Tip: paste .git repo" do 

    	end

    	it "#Tip: Connect your Github accoutn" do 

    	end

    	it "#errors when pasting a invalid .git address" do 

    	end

    	it "does create an opensource app by pasting a .git" do 

    	end

    	it "does create a private app by uploading a .zip file" do 

    	end

    	it "can not create another private app"  do 

    	end


    end

    context "Account connected to github" do 

    end

end



















