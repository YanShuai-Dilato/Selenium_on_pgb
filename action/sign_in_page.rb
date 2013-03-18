$:.unshift File.join(File.dirname(__FILE__),"..")

require 'json'
require File.dirname(__FILE__) + "tools/sign_in_dialog"

class SignInPage
    include SignInDialog

    def initialize(driver)
        @driver = driver
    end

    def sign_in_with
        email_or_adobe_id.send_keys("shuai.yan@dilatoit.com")
        password.send_keys("yanshuai110")
        sign_in_btn.click
    end

    def close_current_browser
        close_browser
    end
end