#encoding: utf-8

require_relative "../lib/webdriver_helper"

module NewAppDialog
    include WebdriverHelper
     
    def new_app_btn
        field = @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:new_app_btn]) 
        highlight_and_return field 
    end
    def close_btn
        field = @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:close_link])  
        highlight_and_return field  
    end
    def first_app_id
        field = @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:first_app_id])
        highlight_and_return field
    end
    def opensource_tab
        field = @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:opensource_repo_tab]) 
        highlight_and_return field 
    end
    def private_tab
        field = @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:private_repo_tab])
        highlight_and_return field    
    end
    def paste_git_repo_input
        field = @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:paste_git_repo_input]) 
        highlight_and_return field   
    end
    def link_connect_your_github_account
        field = @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:connect_your_github_account_link])
        highlight_and_return field
    end
    def error_not_a_valid_address 
        field = @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:not_a_valid_github_url])
        highlight_and_return field
    end 
    def find_existing_repo  
        field = @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:paste_git_repo_input]) 
        highlight_and_return field
    end
    def upload_a_zip_btn 
        field = @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:upload_a_zip_btn])   
        highlight_and_return field 
    end
    def upgrade_link
        field = @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:upgrade_now_link])
        highlight_and_return field
    end

# ---------
    def ready_to_build_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:ready_to_build_btn])
    end
    def rebuild_all_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][])
    end
    def builds_tab
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:builds_tab])
    end
    def collaborators_tab
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:collaborators_tab])
    end
    def settings_tab
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:settings_tab])
    end

    def highlight_and_return field
        highlight field
        return field
    end

end

