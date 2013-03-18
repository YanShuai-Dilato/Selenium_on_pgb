# base_env.rb

module BaseEnv

    def base_url()      
    	"https://build.phonegap.com"     
    end
    def browser()       
    	Selenium::WebDriver.for :chrome    
    end  

    def wait_for_element_present(how_long=5, how, what) 
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        begin
        wait_for_it.until { driver.find_element(how, what) } 
    	rescue Selenium::WebDriver::Error::NoSuchElementError  
    	end  
    end
end