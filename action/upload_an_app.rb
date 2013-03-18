require 'json'
require "tools/new_app_dialog"

class UploadAnApp
    include NewAppDialog

    def initialize(driver)
        @driver = driver
        @base_url = "https://build.phonegap.com"
        @data = JSON.parse(File.read("data/data_xpath.json"))
        @app_data = JSON.parse(File.read("data/data_app.json"))
    end

    def new_app_with_zip
        get_btn_new_app.click
        get_btn_close.click
        get_btn_new_app.click
        sleep 1
        get_private_tab.click
        sleep 1
        # get_upload_a_zip.clear
        get_upload_a_zip.send_keys @app_data["new_app"]["by_zip"]
        sleep 5
        # get_ready_to_build.click
    end

    def new_app_with_pub_repo
        get_btn_new_app.click
        get_opensource.click
        puts @app_data["new_app"]["by_repo"]
        get_paste_git_repo.send_keys @app_data["new_app"]["by_repo"]
        sleep 5
    end

    def close_current_browser
        @driver.quit
    end
end