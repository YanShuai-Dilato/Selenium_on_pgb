# new_app_dialog.rb

module NewAppDialog
     
    def new_app_btn()           
        @new_app_btn ||= @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:new_app_btn])    
    end
    def close_btn()             
        @close_btn ||= @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:close])    
    end
    def opensource_tab()        
        @opensource_tab ||= @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:opensource_repo]) 
    end
    def private_tab()           
        @private_tab ||= @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:private_repo])    
    end
    def placeholder_paste_git_repo()        
        @paste_git_repo ||= @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:paste_git_repo])    
    end
    def link_connect_your_github_account() 
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:connect_to_github_account])
    end
    def error_not_a_valid_address 
        @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][])
    end 
    end
    def find_existing_repo()    
        @find_existing_repo ||= @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:paste_git_repo]) 
    end
    def upload_a_zip()          
        @upload_a_zip ||= @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][:upload_a_zip])    
    end
    def close_browser()         
        @driver.quit    
    end
end

