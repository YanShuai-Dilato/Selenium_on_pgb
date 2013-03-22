require 'json'
require "../tools/new_app_dialog"
require "../data/base_env"

class NewAppPage
    include NewAppDialog
    include BaseEnv

    def initialize(driver)
        @driver = driver
        @base_url = "https://build.phonegap.com"
        @data = YAML::load(File.read("../data/data_xpath.yaml"))
        @app_data = YAML::load(File.read("../data/data_app.yaml"))
    end

    def new_app_with_zip
        new_app_btn.click
        private_tab.click
        upload_a_zip.send_keys @app_data[:new_app][:by_zip]
        sleep 5
        # wait_for_element_present(5, :xpath, @data[:sign_in_succ_page][:ready_to_build])
    end

    def new_app_with_pub_repo
        new_app_btn.click
        close_btn.click
        new_app_btn.click
        opensource_tab.click
        paste_git_repo.send_keys @app_data[:new_app][:by_repo]
        wait_for_element_present(5, :xpath, @data[:sign_in_succ_page][:ready_to_build])
    end

    def close_current_browser
        @driver.quit
    end
end