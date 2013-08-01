#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'yaml'
require 'selenium-webdriver'

require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"
require_relative "../action/sign_in_page"
require_relative "../data/base_env"
require_relative "../tools/plugins_dialog"
require_relative "../tools/header_dialog"

describe "TC_012: Check 'Plugins' page after signing in" do 
    include BaseEnv
    include ConfigParam
    include WebdriverHelper
    include PluginsDialog
    include HeaderDialog

    before(:all) do 
        init
        @order_of_it = WebdriverHelper::Counter.new
        @name_screenshot = "TC_012_IT_"
        @base_url = base_url
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_plugin = YAML::load(File.read(File.expand_path("../../data/data_plugin.yml",__FILE__)))
        @driver = browser 
        @driver.manage.window.maximize
        @driver.execute_script("window.resizeTo(screen.width,screen.height)")
        
        @driver.get path_format_locale("/people/sign_in")

        @sign_in_page = SignInPage.new @driver, xpath: @data_xpath, url: @data_url, user: @data_user
        @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_002][:id],
                                            @data_user[$lang][:adobe_id_free_002][:password])
        @driver.get path_format_locale("/plugins")
    end

    after(:all) do 
        @driver.quit
    end

    after(:each) do  # Take screenshot in case of failure
        @name_screenshot += @order_of_it.inc.to_s

        if example.exception != nil
            take_screenshot_with_name @name_screenshot
        end
    end

    describe "The first time signing in" do 

        it "IT_001: should have no submitted plugins" do 
            plugin_dialog_get(:tab_your_plugins).click
            plugin_dialog_get(:you_have_no_plugins).text.should eql @data_str[$lang][:plugin_you_have_no_plugins]
        end
    end

    describe "Trying to submit plugin with Adobe ID (which has NOT been connected to Github)" do 
        before(:all) do 
           plugin_dialog_get(:tab_submit_plugin).click 
        end

        after(:all) do 
            # To delete the submitted plugin 
        end

        it "IT_002: should match to localized error msg when filling in repo url with invalid one" do 
            plugin_dialog_get(:plugin_git_repository_url).send_keys(@data_plugin[:invalid_plugin][:url])
            plugin_dialog_get(:plugin_git_repository_url_msg).text.should @data_str[$lang][:plugin_git_url_error_msg]
        end

        it "IT_003: should match to localized msg when filling in repo url with valid one" do 
            plugin_dialog_get(:plugin_git_repository_url).send_keys(@data_plugin[:new_plugin][:url])
            plugin_dialog_get(:plugin_git_repository_url_msg).text.should @data_str[$lang][:plugin_git_url_valid_msg]
        end

        it "IT_004: should submit plugin successfully" do 
            plugin_dialog_get(:plugin_git_repository_url).clear
            plugin_dialog_get(:plugin_git_repository_url).send_keys(@data_plugin[:new_plugin][:url])
            plugin_dialog_get(:optional_tag_or_branch).send_keys(@data_plugin[:new_plugin][:branch])
            plugin_dialog_get(:btn_submit_plugin).click
            plugin_dialog_get(:checkbox_accept_license).click
            plugin_dialog_get(:btn_reset).click
            # plugin_dialog_get(:btn_submit).click # will submit the plugin
            "abc".should eql "abc"
        end
    end

    describe "Trying to submit plugin with Adobe ID (which has been connected to Github)" do 
        before(:all) do 
            # sign out 
            # sign in with another account, which has connected with Github 
            # 
            puts "Hello"
        end

        after(:all) do 
            puts "World"
        end

        it "abc should eql abc 1" do  # do something similar to the previous describe block.  
            "abc".should eql "abc"
        end

        it "abc should eql abc 2" do 
            "abc".should eql "abc"
        end
    end

end