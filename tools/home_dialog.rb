#encoding: utf-8

module HomeDialog
    def home_home()         @the_home_page = @data[:home_page]     end
    def home_link()         @driver.find_element(:xpath => home_home[:home])    end
    def docs_link()         @driver.find_element(:xpath => home_home[:docs])    end
    def blog_link()         @driver.find_element(:xpath => home_home[:blog])    end
    def support_link()      @driver.find_element(:xpath => home_home[:support])    end
    def sign_in_link()      @driver.find_element(:xpath => home_home[:sign_in])    end
    def register_link()     @driver.find_element(:xpath => home_home[:register])     end
    def get_started_link()  @driver.find_element(:xpath => home_home[:get_started])    end
    def free_plan_link()    @driver.find_element(:xpath => home_home[:free_plan])    end
    def paid_plan_link()    @driver.find_element(:xpath => home_home[:paid_plan])    end
    def close_browser()     @driver.quit    end
end
