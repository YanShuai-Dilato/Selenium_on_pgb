# base_env.rb

module BaseEnv

    def base_url()      
    	"https://build.phonegap.com"     
    end
    def browser()       
    	Selenium::WebDriver.for :chrome
    end  
    def user_adobe_id()
        {:username => "shuai.yan@dilatoit.com", :password => "yanshuai110"}
    end
    def user_github_id() 
        {:username => "shuai.yan@dilatoit.com", :password => "yanshuai110"}
    end

    def wait_for_element_present(how_long=5, how, what) 
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.find_element(how, what) } 
    end

    def wait_for_page_open(how_long=5, url)
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.current_url == url } 
    end

    def wait_for_page_with_title(how_long=5, title)
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.title.downcase == title}
    end
end