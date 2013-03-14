# new_app_dialog.rb

module NewAppDialog
    def home()                  @the_home_page = @data["sign_in_succ"]    end
    def get_btn_new_app()       @driver.find_element(:xpath => home["new_app"])    end
    def get_btn_close()         @driver.find_element(:xpath => home["close"])    end
    def get_opensource()        @driver.find_element(:xpath => home["opensource_repo"]);end
    def get_paste_git_repo()    @driver.find_element(:xpath => home["paste_git_repo"])    end
    def get_private_tab()       @driver.find_element(:xpath => @data["sign_in_succ"]["private_repo"])    end
    def get_upload_a_zip()      @driver.find_element(:xpath => @data["sign_in_succ"]["upload_a_zip"])    end
    def close_browser()         @driver.close    end
end