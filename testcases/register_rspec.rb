# register_rspec.rb

require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'yaml'

require_relative "../tools/register_dialog"
require_relative "../tools/sign_in_github_dialog"
require_relative "../data/base_env"

describe "Register" do 
	include RegisterDialog
    include SignInGithubDialog
	include BaseEnv

	before(:all) do 
		init
		@base_url = base_url
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
	end

	before(:each) do 
		@driver = browser
		@driver.get path_format_locale("/plans")
	end

	after(:each) do 
        @driver.quit
	end

	describe "#free plan" do
		before(:all) do 
			@register_page = RegisterPage.new(@driver)
        end

        before(:each) do
            @driver.get path_format_locale("/plans/free")
        end

        after(:each) do
            @register_page.close_current_page
        end

        context " with an Adobe ID" do
            before(:all) do
                @driver.get path_format_locale("/plans/free-adobeid")
            end

            after(:each) do
                @register_page.reset_page_content
            end

            context "#Sign in" do
                it " with invalid Adobe ID" do

                end

                it " with valid Adobe ID" do

                end
            end
        end

        context " with GitHub ID" do
            before(:each) do 
                github_btn.click
            end
            it " by email only registered on github" do 
                @user = {
                    :username => "",
                    :password => ""
                }
                SignInGithubDialog::enter_account(@user)
                @driver.current_url.should eql "https://buildstage.phonegap.com/people/link"
            end
            

            it " by email already registered on phonegap_build" do 
            end
        end
    end


    describe "#paid plan" do
        before(:all) do 
        end
        before(:each) do 
        end
        after(:each) do 
        end
        context "Create your account" do 
            context "=> Sign in" do 
                before(:all) do 

                end

                it "with invalid or unmatched account" do
                    # ...
                end

                it "with valid account" do 
                    # ... 
                end
            end

            context "=> Create an Adobe ID" do 
                before(:all) do 
                    @driver.get "https://buildstage.phonegap.com/plans/paid"
                    create_an_adobe_id.click
                end

                after(:each) do # clear the fields' content

                end

                it "with invalid email address" do 
                end

                it "with unmatched password" do 
                end

                it "with invalid first_name" do 
                end

                it "with invalid last_name" do 
                end

                it "with valid account" do 
                end


            end
        end

end