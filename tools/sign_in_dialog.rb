# sign_in_dialog.rb

module SignInDialog
    def home_signin()   
        @the_home_page = @data[:sign_in_page]
    end

    def email_or_adobe_id()     @driver.find_element(:xpath => home_signin[:adobe_id]) end
    def password()              @driver.find_element(:xpath => home_signin[:password]) end
    def sign_in_btn()           @driver.find_element(:xpath => home_signin[:btn_sign_in]) end
    def sign_in_with_github()   @driver.find_element(:xpath => home_signin[:btn_sign_in_with_github]) end
    def forgot_my_password_link 
    	@driver.find_element(:xpath => @data[:sign_in_page][:i_forgot_my_password]) 
    end
    def close_browser()         @driver.quit end

end
