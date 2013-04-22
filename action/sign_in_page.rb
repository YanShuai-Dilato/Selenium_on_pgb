#encoding: utf-8
require 'yaml'

require_relative "../tools/sign_in_dialog"
require_relative "../tools/sign_in_github_dialog"
require_relative "../data/base_env"
require_relative "../lib/webdriver_helper"

class SignInPage
    include SignInDialog
    include SignInGithubDialog
    include BaseEnv
    include WebdriverHelper

    def initialize(driver)
        @driver = driver
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_url = YAML::load(File.read(File.expand_path("../../data/data_url.yml",__FILE__)))
        @data_user = YAML::load(File.read(File.expand_path("../../data/data_user.yml",__FILE__)))
        @data_str = YAML::load(File.read(File.expand_path("../../data/data_str.yml",__FILE__)))
    end

    def sign_in_with_adobe_id(id,password)
        puts "+ id_textinput's type: "
        puts "+ #{id_textinput.attribute('type')}"
        puts "+ end"

        @driver.execute_script(
            " oldObj = document.findElementById('person_email'); " + 
            " var newObject = document.createElement('input'); " + 
            " newObject.type = 'text'; " + 
            " if(oldObject.size) newObject.size = oldObject.size; " + 
            " if(oldObject.value) newObject.value = oldObject.value; " + 
            " if(oldObject.name) newObject.name = oldObject.name; " +
            " if(oldObject.id) newObject.id = oldObject.id; " + 
            " if(oldObject.className) newObject.className = oldObject.className; " + 
            " oldObject.parentNode.replaceChild(newObject,oldObject); "       
        )

        # highlight 
        highlight(:id, "person_email")

        sleep 30

        puts "+ after execute_script"
        puts "+ id_textinput's type: "
        puts "+ #{@driver.find_element(:id => 'person_email').attribute('type')}"
        puts "+ end"

        id_textinput.send_keys(id)
        password_textinput.send_keys(password)
        sign_in_btn.click
    end

    def sign_in_with_github_id(id,password) 
        sign_in_with_github_btn.click
        # wait_for_page_with_title(5, "sign in · github") # it works
        git_id_textinput.send_keys(id)
        git_password_textinput.send_keys(password)
        git_sign_in_btn.click
    end

    def forget_password_with_valid_email(a_valid_email)
        forgot_my_password_link.click
        forgot_password_email_input.send_keys(a_valid_email)
        forgot_password_reset_btn.click
        sleep 5
        @tips_on_receiving_an_email = @driver.find_element(:xpath => @data_xpath[:sign_in_page][:you_will_receive_an_email]).text
    end

    def forget_password_with_invalid_email(a_invalid_email)
        forgot_my_password_link.click
        forgot_password_email_input.send_keys(a_invalid_email)
        forgot_password_reset_btn.click
        @warnings = @driver.find_element(:xpath => @data_xpath[:sign_in_page][:tips_or_warnings]).text
    end

    def resend_confirmation_instructions(email_address)
        didnt_receive_confirmation_link.click
        resend_confirm_instru_email_input.send_keys(email_address)
        resend_confirm_instru_btn.click
        @tips_or_warnings = @driver.find_element(:xpath => @data_xpath[:sign_in_page][:tips_or_warnings]).text
    end

    def open_forgot_my_password
        forgot_my_password_link.click
    end

    def close_current_browser
        close_browser
    end
end