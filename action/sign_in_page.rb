# sign_in_page.rb

require 'json'
require File.dirname(__FILE__) + "\\..\\tools\\sign_in_dialog"

class SignInPage
    include SignInDialog

    def initialize(driver)
        @driver = driver
        @user = JSON.parse(File.read("..\\config\\data_user.json"))
    end

    def sign_in_with
        get_field_adobe_id.send_keys(@user["registered_user"]["valid_user"]["username"])
        get_field_password.send_keys(@user["registered_user"]["valid_user"]["password"])
        get_sign_in.click
        sleep 3
    end

    def close_current_browser
        close_browser
    end
end