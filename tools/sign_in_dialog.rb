# sign_in_dialog.rb

module SignInDialog
    def home()   
        @data = JSON.parse(File.read("..\\config\\data_xpath.json"))           
        @the_home_page = @data["sign_in_page"] 
    end

    def get_field_adobe_id()    @driver.find_element(:xpath => home["adobe_id"]) end
    def get_field_password()    @driver.find_element(:xpath => home["password"]) end
    def get_sign_in()        @driver.find_element(:xpath => home["btn_sign_in"]) end
    def close_browser()     @driver.close end
end

# need 
# => a driver @driver
# => a data @data