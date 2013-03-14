# base_env.rb

class BaseEnv
    def BaseEnv.base_url()         "https://build.phonegap.com"    
    end
    def BaseEnv.browser()       Selenium::WebDriver.for :firefox 
    end 
    def BaseEnv.Expect(item) # xxx
    end   
end