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

describe "TC_001: New app(s) with free account" do
  include BaseEnv
  include ConfigParam
  include WebdriverHelper
  include NewAppDialog
  include AppIDDialogs

  before(:all) do 
    # sign in -> new app
    init
    @order_of_it = WebdriverHelper::Counter.new
    @name_screenshot = "TC_016_IT_"
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


  describe "---  App Details -> Collaborators  ---" do 

    it "should create an app successfully" do 

      puts "created_app_id: #{@app_id}"
      @app_id.should =~ /\d/

      @driver.navigate.refresh
      sleep 15
      ready_to_build_btn.click
      sleep 15

      @current_url = @driver.current_url
      @driver.get "#{@current_url}/#{@app_id}/builds"
      sleep 10
      collaborators(:tab).click
      collaborators(:add_collaborator_btn).click
    end
    
    it "IT_001: should add no collaborators using 'invalid email address'" do 

      # change_element_type_by_name :name => "email", :to_type => "text"
      # puts "+ <> after 'change_element_type_by_name'"
      fill_in collaborators(:email_address_input), :with => "something_of_no_email_format"
      collaborators(:role_reader_radio_btn).click
      collaborators(:submit_btn).click
      
      @driver.current_url.should =~ /\S+\d\/collaborators/

      number_of_collaborators = collaborators(:collaborators_block).find_elements(:tag_name => 'li').count
      number_of_collaborators.should eql 0
    end

    it "IT_002: should be one role_tester in the list" do 

      fill_in collaborators(:email_address_input), :with => "phonegap_plugin@126.com"
      collaborators(:role_reader_radio_btn).click
      collaborators(:submit_btn).click

      sleep 5
      @driver.current_url.should =~ /\S+\d\/collaborators/

      number_of_collaborators = collaborators(:collaborators_block).find_elements(:tag_name => 'li').count
      number_of_collaborators.should eql 1

      collaborators(:first_collaborator_role).text.should eql @data_str[$lang][:role_tester]
    end

    it "IT_003: should be changed to role_developer" do 

      # collaborators(:first_collaborator_edit).click
      @driver.execute_script(
        "document.getElementById('edit-person-#{@app_id}').style.display = 'block'; "
      )
      collaborators(:role_writer_radio_btn).click
      collaborators(:submit_btn).click
      sleep 5

      @driver.current_url.should =~ /\S+\d\/collaborators/

      number_of_collaborators = collaborators(:collaborators_block).find_elements(:tag_name => 'li').count
      number_of_collaborators.should eql 1

      collaborators(:first_collaborator_role).text.should eql @data_str[$lang][:role_deveoper]
    end

    it "IT_004: the collaborator should be deleted" do 

      collaborators(:first_collaborator_delete).click
      collaborators(:first_collaborator_confirm).click
      sleep 5

      @driver.current_url.should =~ /\S+\d\/collaborators/

      number_of_collaborators = collaborators(:collaborators_block).find_elements(:tag_name => 'li').count
      number_of_collaborators.should eql 0
    end

  end
end