# new_app_dialog.rb

module NewAppDialog
    def home_newapp()                  
        @the_home_page = @data_xpath[:sign_in_succ_page]    
    end
        
    def new_app_btn()           
        @new_app_btn ||= @driver.find_element(:xpath => home_newapp[:new_app_btn])    
    end
    def close_btn()             
        @close_btn ||= @driver.find_element(:xpath => home_newapp[:close])    
    end
    def opensource_tab()        
        @opensource_tab ||= @driver.find_element(:xpath => home_newapp[:opensource_repo]) 
    end
    def private_tab()           
        @private_tab ||= @driver.find_element(:xpath => home_newapp[:private_repo])    
    end
    def paste_git_repo()        
        @paste_git_repo ||= @driver.find_element(:xpath => home_newapp[:paste_git_repo])    
    end
    def find_existing_repo()    
        @find_existing_repo ||= @driver.find_element(:xpath => home_newapp[:paste_git_repo]) 
    end
    def upload_a_zip()          
        @upload_a_zip ||= @driver.find_element(:xpath => home_newapp[:upload_a_zip])    
    end
    def close_browser()         
        @driver.quit    
    end
end

