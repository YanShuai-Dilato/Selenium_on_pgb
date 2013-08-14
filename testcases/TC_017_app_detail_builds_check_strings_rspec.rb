#encoding: utf-8

require 'rubygems'
require 'rspec'
require 'yaml'
require 'selenium-webdriver'

require_relative "../lib/config_param"
require_relative "../lib/webdriver_helper"
require_relative "../action/sign_in_page"
require_relative "../action/new_app_page"
require_relative "../tools/new_app_dialog"
require_relative "../data/base_env"
require_relative "../tools/app_id_dialogs"

describe "TC_017: App Details #Builds" do
  include BaseEnv
  include ConfigParam
  include WebdriverHelper
  include NewAppDialog
  include AppIDDialogs

  before(:all) do 
    # sign in -> new app
    init
    @order_of_it = WebdriverHelper::Counter.new
    @name_screenshot = "TC_017_IT_"
    @base_url = base_url
    @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
    @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
    @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
    @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))

    @driver = browser 
    @driver.manage.window.maximize
    @driver.execute_script("window.resizeTo(screen.width,screen.height)")

    @sign_in_page = SignInPage.new @driver, xpath: @data_xpath, url: @data_url, user: @data_user
    @driver.get path_format_locale("/people/sign_in")  
    @sign_in_page.sign_in_with_adobe_id(@data_user[$lang][:adobe_id_free_002][:id],
                                        @data_user[$lang][:adobe_id_free_002][:password])

    @new_app_page = NewAppPage.new(@driver)

    @new_app_page.new_public_app_with_repo
    sleep 15
    @app_id = @new_app_page.get_first_app_id
    puts "+ +New App ID: #{@app_id}"
  end

  after(:all) do 
    begin
      webhelper_delete_all_apps @data_user[$lang][:adobe_id_free_002][:id], @data_user[$lang][:adobe_id_free_002][:password]
    ensure
      @driver.quit
    end
  end

  after(:each) do  # Take screenshot in case of failure
    @name_screenshot += @order_of_it.inc.to_s

    if example.exception != nil
      take_screenshot_with_name @name_screenshot
    end
  end

  describe "Check strings within 'class=\"meta ui-block\"' at 'App Builds' Page" do 
    before do 
      @driver.navigate.refresh
      sleep 15
      ready_to_build_btn.click
      sleep 15

      @current_url = @driver.current_url
      @driver.get "#{@current_url}/#{@app_id}/builds"
      sleep 10
      builds(:tab).click
    end

    it "IT_001: should match to localized strings" do 

      builds(:app_id_label).text.should eql   @data_str[$lang][:builds_app_id_label]
      builds(:version_label).text.should eql  @data_str[$lang][:builds_version_label]
      builds(:phonegap_label).text.should eql @data_str[$lang][:builds_phonegap_label]
      builds(:owner_label).text.should eql    @data_str[$lang][:builds_owner_label]
      builds(:last_built_label).text.should   include(@data_str[$lang][:builds_last_built_label])
      builds(:source_label).text.should eql   @data_str[$lang][:builds_source_label]
    end
  end

  describe "Check strings within 'class=\"clearfix packages\"' at 'App Builds' Page" do 
    before do 
      
    end

    it "IT_002: should match to localized strings: >> iOS <<" do 

      until @data_str[$lang][:builds_action_pending] != builds(:ios_action).text do 
        @driver.navigate.refresh
        sleep 5
        puts "+ action: " + builds(:ios_action).text 
      end
      puts "+ iOS action: " + builds(:ios_action).text
      puts "+ iOS message: " + builds(:ios_msg).text
      builds(:ios_rebuild).text.should  eql @data_str[$lang][:builds_rebuild]
      builds(:ios_label).text.should    eql @data_str[$lang][:builds_label]
      builds(:ios_options).attribute('label').should  eql @data_str[$lang][:builds_options]
      builds(:ios_no_key).text.should   eql @data_str[$lang][:builds_no_key]
      builds(:ios_new_key).text.should  eql @data_str[$lang][:builds_new_key]
    end

    it "IT_003: should match to localized strings: >> Android <<" do 

      until @data_str[$lang][:builds_action_pending] != builds(:android_action).text do 
        @driver.navigate.refresh
        sleep 5
        puts "+ action: " + builds(:android_action).text
      end
      builds(:android_rebuild).text.should  eql @data_str[$lang][:builds_rebuild]
      builds(:android_label).text.should    eql @data_str[$lang][:builds_label]
      builds(:android_options).attribute('label').should  eql @data_str[$lang][:builds_options]
      builds(:android_no_key).text.should   eql @data_str[$lang][:builds_no_key]
      builds(:android_new_key).text.should  eql @data_str[$lang][:builds_new_key]
    end

    it "IT_004: should match to localized strings: >> WinPhone <<" do 

      until @data_str[$lang][:builds_action_pending] != builds(:winphone_action).text do 
        @driver.navigate.refresh
        sleep 5
        puts "+ action: " + builds(:winphone_action).text
      end
      builds(:winphone_rebuild).text.should eql @data_str[$lang][:builds_rebuild]
    end

    it "IT_005: should match to localized strings: >> BlackBerry <<" do 

      until @data_str[$lang][:builds_action_pending] != builds(:blackberry_action).text do 
        sleep 5
        puts "+ action: " + builds(:blackberry_action).text
      end
      builds(:blackberry_rebuild).text.should  eql @data_str[$lang][:builds_rebuild]
      builds(:blackberry_label).text.should    eql @data_str[$lang][:builds_label]
      builds(:blackberry_options).attribute('label').should  eql @data_str[$lang][:builds_options]
      builds(:blackberry_no_key).text.should   eql @data_str[$lang][:builds_no_key]
      builds(:blackberry_new_key).text.should  eql @data_str[$lang][:builds_new_key]
    end

    it "IT_006: should match to localized strings: >> WebOS <<" do 

      until @data_str[$lang][:builds_action_pending] != builds(:webos_action).text do 
        sleep 5
        puts "+ action: " + builds(:webos_action).text
      end
      builds(:webos_rebuild).text.should eql @data_str[$lang][:builds_rebuild]
    end

    it "IT_007: should match to localized strings: >> Symbian <<" do 

      until @data_str[$lang][:builds_action_pending] != builds(:symbian_action).text do 
        sleep 5
        puts "+ action: " + builds(:symbian_action).text
      end  
      builds(:symbian_rebuild).text.should eql @data_str[$lang][:builds_rebuild]
    end
  end


end