# new_app_dialog.rb

module NewAppDialog
    def home
        @the_home_page = @data["sign_in_succ"]
    end

    def get_btn_new_app
        @driver.find_element(:xpath => @data["sign_in_succ"]["new_app"])
    end

    def get_btn_close
        @driver.find_element(:xpath => @data["sign_in_succ"]["close"])
    end

    def get_private_tab
        @driver.find_element(:xpath => @data["sign_in_succ"]["private_repo"])
    end

    def get_upload_a_zip
        @driver.find_element(:xpath => @data["sign_in_succ"]["upload_a_zip"])
    end

    def get_enable_debug
        @driver.find_element(:xpath => @data["sign_in_succ"]["enable_debug"])
    end

    def get_enable_hydration
        @driver.find_element(:xpath => @data["sign_in_succ"]["enable_hydration"])
    end

    def get_ready_to_build
        @driver.find_element(:xpath => @data["sign_in_succ"]["ready_to_build"])
    end

    def get_delete
        @driver.find_element(:xpath => @data["sign_in_succ"]["delete"])
    end

    #   and some more 

    def close_browser
        @driver.close
    end
end