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

        if upload_a_zip 
            upload_a_zip.send_keys (File.expand_path("../../assets/application/www.zip",__FILE__))
        else
            return false
        end
        # wait_for_element_present(5, :xpath, @data[:sign_in_succ_page][:ready_to_build])
    end

    def new_public_app_with_repo
        if new_app_btn 
            new_app_btn.click
        end
        opensource_tab.click
        paste_git_repo.send_keys @app_data[:new_app][:by_repo]
        # wait_for_element_present(5, :xpath, @data_xpath[:sign_in_succ_page][:ready_to_build])
    end

    def new_private_app_with_repo
        if new_app_btn
            new_app_btn.click
        end
        private_tab.click
        if paste_git_repo 
            paste_git_repo.send_keys @app_data[:new_app][:by_repo]
        else
            return false
        end
    end

    def new_created_app_info
        @hash_the_actual_app_info = {
            "title" => @driver.find_element(:xpath => @data_xpath[:app_brief_detail][:app_title]).text,
            "description" => @driver.find_element(:xpath => @data_xpath[:app_brief_detail][:app_description]).text,
            "version" => @driver.find_element(:xpath => @data_xpath[:app_brief_detail][:app_version]).text,
            "source" => @driver.find_element(:xpath => @data_xpath[:app_brief_detail][:app_source]).text
        }
        @hash_the_actual_app_info.to_a
    end

    def expected_app_info_by_repo
        @hash_the_expected_app_info = {
            "title" => @app_data[:expected_app_by_repo][:title],
            "description" => @app_data[:expected_app_by_repo][:description],
            "version" => @app_data[:expected_app_by_repo][:version],
            "source" => @app_data[:expected_app_by_repo][:source]
        }
        @hash_the_expected_app_info.to_a
    end

    def expected_app_info_by_zip
        @hash_the_expected_app_info = {
            "title" => @app_data[:expected_app_by_zip][:title],
            "description" => @app_data[:expected_app_by_zip][:description],
            "version" => @app_data[:expected_app_by_zip][:version],
            "source" => @app_data[:expected_app_by_zip][:source]
        }
        @hash_the_expected_app_info.to_a
    end

    def close_current_browser
        @driver.quit
    end
end