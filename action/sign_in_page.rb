#encoding: utf-8
require 'json'
require "../tools/sign_in_dialog"
require "../tools/sign_in_github_dialog"
require "../data/base_env"

class SignInPage
    include SignInDialog
    include SignInGithubDialog
    include BaseEnv

    def initialize(driver)
        @driver = driver
        @data = YAML::load(File.read("../data/data_xpath.yaml"))
    end

    def sign_in_with_adobe_id
        email_or_adobe_id.send_keys(user_adobe_id[:username])
        password.send_keys(user_adobe_id[:password])
        sign_in_btn.click
    end

    def sign_in_with_github_id
        sign_in_with_github.click
        wait_for_page_with_title(5, "sign in · github") # it works
        gh_username.send_keys(user_github_id[:username])
        gh_password.send_keys(user_github_id[:password])
        gh_sign_in.click
    end

    def open_forgot_my_password
        forgot_my_password_link.click
    end

    def close_current_browser
        close_browser
    end
end