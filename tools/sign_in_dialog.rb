# sign_in_dialog.rb

module SignInDialog
    def home
        @the_home_page = @data["sign_in_page"]
    end

    def field_adobe_id
        @driver.find_element(:xpath => home["adobe_id"])
    end

    def field_password
        @driver.find_element(:xpath => home["password"])
    end

    def to_sign_in
        @driver.find_element(:xpath => home["btn_sign_in"])
    end

    #   and some more 

    def close_browser
        @driver.close
    end
end