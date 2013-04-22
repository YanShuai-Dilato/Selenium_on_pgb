# new_app_dialog.rb

module NewAppDialog
     
    def new_app_btn
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:new_app_btn])    
    end
    def close_btn
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:close_link])    
    end
    def first_app_id
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:first_app_id])
    end
    def opensource_tab
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:opensource_repo_tab]) 
    end
    def private_tab
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:private_repo_tab])    
    end
    def paste_git_repo_input
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:paste_git_repo_input])    
    end
    def link_connect_your_github_account
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:connect_your_github_account_link])
    end
    def error_not_a_valid_address 
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:not_a_valid_github_url])
    end 
    def find_existing_repo  
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:paste_git_repo_input]) 
    end
    def upload_a_zip_btn 
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:upload_a_zip_btn])    
    end
    def upgrade_link
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:upgrade_now_link])
    end

end

