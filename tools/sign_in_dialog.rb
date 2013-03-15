# sign_in_dialog.rb

module SignInDialog
    def home()   
        @data = JSON.parse(File.read("..\\data\\data_xpath.json"))
        @the_home_page = @data["sign_in_page"] 
    end

    def email_or_adobe_id()     @driver.find_element(:xpath => home["adobe_id"]) end
    def password()              @driver.find_element(:xpath => home["password"]) end
    def sign_in_btn()           @driver.find_element(:xpath => home["btn_sign_in"]) end
    def sign_in_with_github()   @driver.find_element(:xpath => home[]) end
    def close_browser()         @driver.close end

end

# need 
# =>  @driver
# =>  @data