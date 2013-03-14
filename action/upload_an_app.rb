# upload_an_app.rb

require 'json'
require File.dirname(__FILE__) + "\/..\/tools\/new_app_dialog"

class UploadAnApp
    include NewAppDialog

    def initialize(driver)
        @driver = driver
        @base_url = "https://build.phonegap.com"
        @data = JSON.parse(File.read("..\/config\/data_xpath.json"))
        @app_data = JSON.parse(File.read("..\/config\/data_app.json"))
        # @driver.manage.timeout.implicit_wait = 30
    end

    def new_app_with_zip
        # @driver.get @base_url + "/apps"
        # sleep 3
        get_btn_new_app.click
        puts get_btn_new_app.text
        get_btn_close.click
        get_btn_new_app.click
        sleep 1
        get_private_tab.click
        puts get_private_tab.text
        sleep 1
        # get_upload_a_zip.clear
        puts get_upload_a_zip.text
        get_upload_a_zip.send_keys @app_data["new_app"]["by_zip"]
        sleep 5
        # get_ready_to_build.click
    end

    def new_app_with_pub_repo
        get_btn_new_app.click
        get_opensource.click
        puts @app_data["new_app"]["by_repo"]
        get_paste_git_repo.send_keys @app_data["new_app"]["by_repo"]
        # get_paste_git_repo.click
        sleep 5
    end

    def get_new_app_id
        raise "not implemented"
    end
end