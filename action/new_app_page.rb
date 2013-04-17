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
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @app_data = YAML::load(File.read(File.expand_path("../../data/data_app.yml",__FILE__)))
    end

    def get_existing_app_num
        @driver.find_elements(:tag_name => "article").count
    end

    def get_first_app_id
        first_app_id.text
    end
    
    def new_btn_exists?
        return isElementPresent?(:id, "new-app-btn")
    end

    def private_app_no?
        new_app_btn.click 
        private_tab.click
        @disabled_or_not_upload =  upload_a_zip.attribute('disabled') # true/false
        @disabled_or_not_paste = txtbox_paste_git_repo.attribute('disabled') # true/false
        if @disabled_or_not_paste && @disabled_or_not_upload
            return true
        end
        return false
    end

    def new_app_with_zip
        if isElementPreset?(:xpath, @data_xpath[:sign_in_succ_page][:new_app_btn])
            new_app_btn.click
        end
        private_tab.click
        #excute javascript to show the element in order to magic uploading file
        @driver.execute_script("arguments[0].style.visibility = 'visible'; arguments[0].style.width = '1px';arguments[0].style.height = '1px';arguments[0].style.opacity = 1",upload_a_zip)
        
        if private_app_no?
            return false
        end
        upload_a_zip.send_keys (File.expand_path("../../assets/application/www.zip",__FILE__))
        return true   
        # wait_for_element_present(5, :xpath, @data[:sign_in_succ_page][:ready_to_build])
    end

    def new_public_app_with_repo
        new_app_btn.click 
        opensource_tab.click
        txtbox_paste_git_repo.send_keys @app_data[:new_app][:by_repo] + "\n"
        # wait_for_element_present(5, :xpath, @data_xpath[:sign_in_succ_page][:ready_to_build])
    end

    def new_private_app_with_repo
        new_app_btn.click 
        private_tab.click
        if paste_git_repo 
            paste_git_repo.send_keys @app_data[:new_app][:by_repo]
        else
            return false
        end
    end

    def paste_a_git_repo(repo_address)
        txtbox_paste_git_repo.send_keys(repo_address + "\n")
        return error_not_a_valid_address.text
    end

    def close_current_browser
        @driver.quit
    end
end