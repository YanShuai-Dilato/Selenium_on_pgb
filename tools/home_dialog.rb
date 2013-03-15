# home_dialog.rb

module HomeDialog
    def home()              @the_home_page = @data["home_page"]     end
    def home_link()         @driver.find_element(:xpath => home["home"])    end
    def docs_link()         @driver.find_element(:xpath => home["docs"])    end
    def blog_link()         @driver.find_element(:xpath => home["blog"])    end
    def support_link()      @driver.find_element(:xpath => home["support"])    end
    def sign_in_link()      @driver.find_element(:xpath => home["sign_in"])    end
    def register_link()     @driver.find_element(:xpath => home["register"])     end
    def get_started_link()  @driver.find_element(:xpath => home["get_started"])    end
    def free_plan_link()    @driver.find_element(:xpath => home["free_plan"])    end
    def paid_plan_link()    @driver.find_element(:xpath => home["paid_plan"])    end
    def close_browser()     @driver.close    end
end

# require 
# => @data 
# => @driver