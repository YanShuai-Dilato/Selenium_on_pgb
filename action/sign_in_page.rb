#encoding: utf-8
require 'yaml'

require_relative "../tools/sign_in_dialog"
require_relative "../tools/sign_in_github_dialog"
require_relative "../data/base_env"
require_relative "../lib/webdriver_helper"
require_relative "../lib/config_param"

class SignInPage
    include SignInDialog
    include SignInGithubDialog
    include BaseEnv
    include WebdriverHelper
    include ConfigParam
    
    # Initialize an SignInPage instance by providing a driver and the 'options' array. 
    # How to use: 
    # @sign_in_page = SignInPage.new @driver, xpath: @data_xpath, url: @data_url, str: @data_str, user: @data_user
    def initialize(driver, options = {})
        puts "+ <action> initialize SignInPage --- begin"
        @driver = driver
        @data_xpath = options.fetch(:xpath)
        @data_user = options.fetch(:user)
        @data_url = options.fetch(:url)
        puts "+ <action> initialize SignInPage --- end"
    end

    # By receiving user's ID and password, 
    # this method helps to fill in and submit the user form. 
    def sign_in_with_adobe_id(id,password)
        puts "+ <action> sign_in_with_adobe_id --- begin"

        # Chrome's warning message about invalid information just 
        # stop us to click the 'Sign in' button. 
        # So we decide to change its type and just disable the chrome feature 
        # to continue our steps. 
        if $browser == :chrome   
            change_element_attribute(attribute:"type", id:"person_email", to:"text" ) 
        end
        puts "+ <action> Sign In with"
        puts "+ <action>     id:       #{id}"
        puts "+ <action>     password: #{password}"

        id_textinput.send_keys(id)
        password_textinput.send_keys(password)
        sign_in_btn.click
        puts "+ <action> sign_in_with_adobe_id --- end"
    end

    # By receiving user's ID and password,
    # this method helps to fill in and submit the user form. 
    def sign_in_with_github_id(id,password) 
        puts "+ <action> sign_in_with_adobe_id --- begin"
        puts "+ <action> with id: #{id}"
        puts "+ <action> with password: #{password}"
        sign_in_with_github_btn.click
        sleep 5
        git_id_textinput.send_keys(id)
        git_password_textinput.send_keys(password)
        git_sign_in_btn.click
        puts "+ <action> sign_in_with_adobe_id --- end"
    end

    # By receiving valid email address, 
    # this method tries to get the kind tips about where to get the recover-password private link. 
    def forget_password_with_valid_email(a_valid_email)
        puts "+ <action> forget_password_with_valid_email --- begin"
        forgot_my_password_link.click
        forgot_password_email_input.send_keys(a_valid_email)
        forgot_password_reset_btn.click
        sleep 5
        tips_on_receiving_an_email = @driver.find_element(:xpath => @data_xpath[:sign_in_page][:you_will_receive_an_email]).text
        puts "+ <action> forget_password_with_valid_email --- end"
        return tips_on_receiving_an_email
    end

    # By receiving invalid email address
    # this method helps to return the warning message 
    def forget_password_with_invalid_email(a_invalid_email)
        puts "+ <action> forget_password_with_invalid_email --- begin"
        forgot_my_password_link.click
        forgot_password_email_input.send_keys(a_invalid_email)
        forgot_password_reset_btn.click
        warnings = @driver.find_element(:xpath => @data_xpath[:sign_in_page][:tips_or_warnings]).text
        puts "+ <action> forget_password_with_invalid_email --- end"
        return warnings
    end

    def open_forgot_my_password
        puts "+ <action> open_forgot_my_password --- begin"
        forgot_my_password_link.click
        puts "+ <action> open_forgot_my_password --- end"
    end
    
end