require 'yaml'
require_relative "../tools/new_app_dialog"
require_relative "../data/base_env"

class NewAppPage
    include NewAppDialog
    include BaseEnv

    def initialize(driver)
        @driver = driver
        @base_url = "https://build.phonegap.com"
        @data = YAML::load(File.read("../data/data_xpath.yml"))
        @app_data = YAML::load(File.read("../data/data_app.yml"))
    end

    def new_app_with_zip
        new_app_btn.click
        private_tab.click
        upload_a_zip.send_keys @app_data[:new_app][:by_zip]
        sleep 5
        # wait_for_element_present(500,:css,"app-summary ui-block new")
    end

    def new_app_with_pub_repo
        new_app_btn.click
        opensource_tab.click
        paste_git_repo.send_keys @app_data[:new_app][:by_repo]
        sleep 10
        #wait_for_element_present(500,:css,"app-summary ui-block new")
    end

    def close_current_browser
        @driver.quit
    end
end