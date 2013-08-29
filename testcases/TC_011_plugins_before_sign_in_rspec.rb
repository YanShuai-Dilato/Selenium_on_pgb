#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative "../data/base_env"
require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"
require_relative "../tools/plugins_dialog"

describe "TC_011: Check 'Plugins' page before signing in" do 
    include BaseEnv
    include ConfigParam
    include WebdriverHelper
    include PluginsDialog

    before(:all) do 
        init
        @order_of_it = WebdriverHelper::Counter.new
        @name_screenshot = "TC_011_IT_"
        @base_url = base_url
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))

        @driver = browser # have to start a new instance each time to clean the cache.
        @driver.manage.window.maximize
        @driver.execute_script("window.resizeTo(screen.width,screen.height)")

        @driver.get path_format_locale("/plugins")
    end

    after(:all) do  
        @driver.quit
    end

    after(:each) do # Take screenshot in case of failure
        @name_screenshot += @order_of_it.inc.to_s
        if example.exception != nil
            take_screenshot_with_name @name_screenshot
        end
    end

    # This notification has been removed, so we remove this test. 
    it "IT_001: should match to the localized 'notifications' " do 
    #     plugin_dialog_get(:header_notifications).text.should eql @data_str[$lang][:plugin_header_notifications]
          1.should eql 1
    end

    it "IT_002: should match to the localized 'Plugins' " do 
        plugin_dialog_get(:title).text.should eql @data_str[$lang][:plugin_title]
    end

    it "IT_003: should match to the localized 'All Supported Plugins' " do 
        plugin_dialog_get(:tab_all_supported_plugins).text.should eql @data_str[$lang][:plugin_tab_all_supported_plugins]
    end

    it "IT_004: should match to the localized 'Your Plugins' " do 
        plugin_dialog_get(:tab_your_plugins).text.should eql @data_str[$lang][:plugin_tab_your_plugins]
    end

    it "IT_005: should match to the localized 'Submit Plugin' " do 
        plugin_dialog_get(:tab_submit_plugin).text.should eql @data_str[$lang][:plugin_tab_submit_plugin]
    end

    it "IT_006: should match to the localized 'Please sign in to submit or view your plugins.' at 'Your Plugins' tab " do 
        plugin_dialog_get(:tab_your_plugins).click
        plugin_dialog_get(:please_sign_in_your).text.should eql @data_str[$lang][:plugin_please_sign_in_your]
    end

    it "IT_007: should match to correct url '/people/sign_in'" do 
        plugin_dialog_get(:link_sign_in_tab_your_plugins).attribute('href').should eql "#{base_url}/people/sign_in"
    end

    it "IT_008: should match to the localized 'Please sign in to submit or view your plugins.' at 'Submit Plugin' tab " do 
        plugin_dialog_get(:tab_submit_plugin).click
        plugin_dialog_get(:please_sign_in_add).text.should eql @data_str[$lang][:plugin_please_sign_in_add]
    end

    it "IT_009: should match to correct url '/people/sign_in'" do 
        plugin_dialog_get(:link_sign_in_tab_submit_plugin).attribute('href').should eql "#{base_url}/people/sign_in"
    end

end
