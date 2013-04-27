#encoding: utf-8

#helper method for waiting in selenium
module WebdriverHelper

	def wait_for_element_present(how_long=60, how, what) 
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.find_element(how, what) } 
    end

    def wait_for_page_load(how_long=60, url)
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.current_url == url } 
        puts "wait_for_page_load"
    end

    def wait_for_page_with_title(how_long=60, title)
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.title.downcase == title.downcase}
    end

    def isElementPreset?(how_long, how, what)
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.find_element(how, what) }
        return true
    end
    
end    