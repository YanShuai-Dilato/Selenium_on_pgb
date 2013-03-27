# home_dialog.rb

module HomeDialog
    def home_page_data()              
        @home_page_data = @data[:home_page]     
    end

    def home_link()         
        @home_link ||= @driver.find_element(:xpath => home_home[:home])    
    end
    def docs_link()         
        @docs_link ||= @driver.find_element(:xpath => home_home[:docs])    
    end
    def blog_link()         
        @blog_link ||= @driver.find_element(:xpath => home_home[:blog])    
    end
    def support_link()      
        @support_link ||= @driver.find_element(:xpath => home_home[:support])    
    end
    def sign_in_link()      
        @sign_in_link ||= @driver.find_element(:xpath => home_home[:sign_in])    
    end
    def register_link()     
        @register_link ||= @driver.find_element(:xpath => home_home[:register])     
    end
    def get_started_link()  
        @get_started_link ||= @driver.find_element(:xpath => home_home[:get_started])    
    end
    def free_plan_link()    
        @free_plan_link ||= @driver.find_element(:xpath => home_home[:free_plan])    
    end
    def paid_plan_link()    
        @paid_plan_link ||= @driver.find_element(:xpath => home_home[:paid_plan])    
    end
    def close_browser()     
        @driver.quit    
    end
end
