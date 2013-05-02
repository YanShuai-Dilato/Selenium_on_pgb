#encoding: utf-8

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
        @driver.manage.window.maximize
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_app = YAML::load(File.read(File.expand_path("../../data/data_app.yml",__FILE__)))
    end

    def get_existing_app_num
        @driver.find_elements(:tag_name => "article").count
    end

    def get_first_app_id
        first_app_id.text
    end
    
    def new_app_btn_display?
        style = @driver.find_element(:xpath, @data_xpath[:sign_in_succ_page][:new_app_btn]).attribute("style")
        if style.chomp == "display: none;".chomp
            return false
        end
        return true
    end

    def private_app_no?
        disabled_or_not_upload =  upload_a_zip_btn.attribute('disabled') # true/false
        disabled_or_not_paste = paste_git_repo_input.attribute('disabled') # true/false
        if disabled_or_not_paste && disabled_or_not_upload
            return true
        end
        return false
    end

    def new_app_with_zip
        puts "+ new_app_with_zip in new_app_page.rb"
        if new_app_btn_display?
            new_app_btn.click
            sleep 2
            private_tab.click
            sleep 2
        end
        
        puts private_app_no?.to_s
        sleep 3
        if private_app_no?
            return false
        end

        #excute javascript to show the element in order to magic uploading file
        @driver.execute_script("arguments[0].style.visibility = 'visible'; arguments[0].style.width = '1px';arguments[0].style.height = '1px';arguments[0].style.opacity = 1",upload_a_zip_btn)

        upload_a_zip_btn.send_keys (File.expand_path(@data_app[:new_app][:by_zip],__FILE__))

        puts "---------------"
        puts "pwd: " + Dir.pwd  # C:/Users/labuser/Desktop/Selenium_on_pgb
        puts "---------------"
        # upload_a_zip_btn.send_keys ("./assets/application/www.zip")
        
        puts "waiting for uploading file"
        sleep 10
        wait_for_element_present(60, :xpath, @data_xpath[:sign_in_succ_page][:first_app_id])
        return true
    end

    def new_public_app_with_repo
        puts "+ new_public_app_with_repo in new_app_page.rb"

        if new_app_btn_display?
            new_app_btn.click
        end
        opensource_tab.click
        paste_git_repo_input.clear
        paste_git_repo_input.send_keys @data_app[:new_app][:by_repo] + "\n"
        sleep 10
        wait_for_element_present(60, :xpath, @data_xpath[:sign_in_succ_page][:first_app_id])
    end

    def new_private_app_with_repo
        puts "+ new_private_app_with_repo in new_app_page.rb"
        if new_app_btn_display?
            new_app_btn.click
        end
        private_tab.click
        if !private_app_no?
            paste_git_repo_input.send_keys @data_app[:new_app][:by_repo] + "\n"
        else
            return false
        end
    end

    def paste_a_git_repo(repo_address)
        if new_app_btn_display?
            new_app_btn.click
        end
        paste_git_repo_input.send_keys(repo_address + "\n")
        return error_not_a_valid_address.text
    end

end