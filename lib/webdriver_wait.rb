#helper method for waiting in selenium
module WebdriverWait

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
        wait_for_it.until { @driver.title.downcase == title.downcase}
    end
    
end    