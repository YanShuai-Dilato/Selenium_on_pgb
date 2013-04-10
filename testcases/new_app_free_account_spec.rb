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

    context "Account not connected to github" do 
        before(:all) do 
            @driver.get path_format_locale("/people/sign_in")
            SignInPage.new(@driver).sign_in_with_adobe_id(@data_user[$lang][:free_user][:id],@data_user[$lang][:free_user][:password])
        end

        before(:each) do 
            @driver.navigate.refresh
        end

    	it "#Tip: paste .git repo" do 
            placeholder_paste_git_repo.text.should eql @data_str[$lang][:PGB_paste_git_repo]
    	end

    	it "#Tip: Connect your Github account" do 
            link_connect_your_github_account.text.should eql = @data_str[$lang][:PGB_connect_your_github_account]
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



















