# base_env.rb

module BaseEnv
    def base_url()         "https://build.phonegap.com"    
    end
    def browser()       Selenium::WebDriver.for :firefox 
    end 
    def expect(item) # xxx
    end   
    def waiter() Selenium::WebDriver::Wait.new (:timeout => 30)
    end
    def wait_for_element_present(how_long=5, how, what) 
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { browser.find_element(how, what) }        
    end
end