require 'yaml'
require_relative "../tools/new_app_dialog"
require_relative "../data/base_env"
require_relative "../lib/webdriver_helper"

class NewAppPage
    include NewAppDialog
    include BaseEnv
    include WebdriverHelper

    def initialize(driver)
        @driver = driver
        @base_url = "https://build.phonegap.com"
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @app_data = YAML::load(File.read(File.expand_path("../../data/data_app.yml",__FILE__)))
    end

    def new_app_with_zip
        new_app_btn.click
        private_tab.click
        #excute javascript to show the element in order to magic uploading file
        @driver.execute_script("arguments[0].style.visibility = 'visible'; arguments[0].style.width = '1px';arguments[0].style.height = '1px';arguments[0].style.opacity = 1",upload_a_zip)

        upload_a_zip.send_keys (File.expand_path("../../assets/application/www.zip",__FILE__))
        sleep 5
        # wait_for_element_present(5, :xpath, @data[:sign_in_succ_page][:ready_to_build])
    end

    def new_app_with_pub_repo
        new_app_btn.click
        opensource_tab.click
        paste_git_repo.send_keys @app_data[:new_app][:by_repo]
        wait_for_element_present(5, :xpath, @data_xpath[:sign_in_succ_page][:ready_to_build])
    end

    def create_the_second_app_free_account
        new_app_btn.click
        private_tab.click
        
    end

    def close_current_browser
        @driver.quit
    end
end