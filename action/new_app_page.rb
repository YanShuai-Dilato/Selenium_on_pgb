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
        puts "+ <action> initialize NewAppPage -- begin"
        @driver = driver
        @data_xpath = YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
        @data_app   = YAML::load(File.read(File.expand_path("../../data/data_app.yml",__FILE__)))
        puts "+ <action> initialize NewAppPage -- end"
    end

    # Get the number of existing apps by counting the number of tag 'article' 
    def get_existing_app_num
        num = @driver.find_elements(:tag_name => "article").count
        puts "+ <action> existing_app_num: #{num}"
        return num
    end

    # Get the ID of the top one of all apps
    # In order to compare it with new-created app's ID to verify if new app was created successfully. 
    def get_first_app_id
        first_app_id.text
    end
    
    # On the default page after signing in
    # We can NOT see an btn, which says '+ new app', if there aren't any existing apps.
    # We can see the '+ new app' btn, if there are existing apps. 
    # The '+ new app' btn opens the 'creating app' area, which we input information to create apps. 
    def new_app_btn_display?
        style = @driver.find_element(:xpath, @data_xpath[:sign_in_succ_page][:new_app_btn]).attribute("style")
        if style.chomp == "display: none;".chomp
            sleep 5
            puts "+ <action> new_app_btn_display? NO"
            return false
        end
        sleep 5
        puts "+ <action> new_app_btn_display? YES"
        return true
    end

    # Detect whether another private app was able to be created. 
    # Return true if can not
    # Return false if can 
    def private_app_no?
        disabled_or_not_upload =  upload_a_zip_btn.attribute('disabled') # true/false
        disabled_or_not_paste = paste_git_repo_input.attribute('disabled') # true/false
        if disabled_or_not_paste && disabled_or_not_upload
            puts "+ <action> private_app_no? NO"
            return true
        end
        puts "+ <action> private_app_no? YES"
        return false
    end

    # Create an (private) app by uploading a zip file, 
    # which contains files like: index.html, config.xml, *.js, *.css, and more related resource files. 
    # Steps are: 
    #       "private" tab -> "Upload a .zip file" 
    def new_app_with_zip
        puts "+ <action> New app with a zip file --- begin "
        sleep 5
        if new_app_btn_display?
            new_app_btn.click
            sleep 2
            private_tab.click
            sleep 2
        end
        
        puts private_app_no?.to_s
        sleep 3
        if private_app_no?
            puts "+ <action> New app with a zip file --- end "
            return false
        end

        #excute javascript to show the element in order to magic uploading file
        @driver.execute_script("arguments[0].style.visibility = 'visible'; arguments[0].style.width = '1px';arguments[0].style.height = '1px';arguments[0].style.opacity = 1",upload_a_zip_btn)

        os = win_or_mac
        if os == 'mac' 
            upload_a_zip_btn.send_keys (File.expand_path("../../assets/application/anotherあ你äōҾӲ.zip",__FILE__))
        else
            upload_a_zip_btn.send_keys "C:\\anotherあ你äōҾӲ.zip"
        end

        sleep 10
        wait_for_element_present(:xpath, @data_xpath[:sign_in_succ_page][:first_app_id])
        puts "+ <action> New app with a zip file --- end "
        return true
    end

    # Create an public app by submitting a github repo address. 
    # Steps are : 
    #       'open-source' tab -> "paste .git repo"  
    def new_public_app_with_repo
        puts "+ <action> New public app with github repo --- begin"

        # Selenium::WebDriver::Wait.new(:timeout => 120).until { new_app_btn }
        sleep 10
        if new_app_btn_display?
            new_app_btn.click
        end
        opensource_tab.click
        paste_git_repo_input.clear
        paste_git_repo_input.send_keys @data_app[:new_app][:by_repo] + "\n"
        sleep 10
        wait_for_element_present(:xpath, @data_xpath[:sign_in_succ_page][:first_app_id])
        puts "+ <action> New public app with github repo --- end"
    end

    # Create an private app by submitting a github repo address. 
    # Steps are:
    #       'private' tab -> 'paste .git repo'
    def new_private_app_with_repo
        puts "+ <action> New a private app with github repo --- begin" 
        if new_app_btn_display?
            new_app_btn.click
        end
        private_tab.click
        if !private_app_no?
            puts "+ <action> New a private app with github repo --- end" 
            paste_git_repo_input.send_keys @data_app[:new_app][:by_repo] + "\n"
        else
            puts "+ <action> New a private app with github repo --- end" 
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