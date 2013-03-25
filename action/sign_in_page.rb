#encoding: utf-8
require 'yaml'

require_relative "../tools/sign_in_dialog"
require_relative "../tools/sign_in_github_dialog"
require_relative "../data/base_env"
require_relative "../lib/webdriver_wait"

class SignInPage
    include SignInDialog
    include SignInGithubDialog
    include BaseEnv
    include WebdriverWait

    def initialize(driver)
        @driver = driver
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
    end

    def sign_in_with_adobe_id(id,password)
        id_textinput.send_keys(id)
        password_textinput.send_keys(password)
        sign_in_btn.click
    end

    def sign_in_with_github_id(id,password) 
        sign_in_with_github_btn.click
        wait_for_page_with_title(5, "sign in · github") # it works
        git_id_textinput.send_keys(id)
        git_password_textinput.send_keys(password)
        git_sign_in_btn.click
    end

    def open_forgot_my_password
        forgot_my_password_link.click
    end

    def close_current_browser
        close_browser
    end
end