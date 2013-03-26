# sign_in_dialog.rb

module SignInDialog
    def home_signin_data()   
        @home_singin_data ||= @data_xpath[:sign_in_page]
    end

    def id_textinput()
        @id_textinput ||= @driver.find_element(:xpath => home_signin_data[:adobe_id]) end
    def password_textinput()   
        @password_textinput ||= @driver.find_element(:xpath => home_signin_data[:password]) end
    def sign_in_btn()           
        @sign_in_btn = @driver.find_element(:xpath => home_signin_data[:btn_sign_in]) end
    def sign_in_with_github_btn()   
        @sign_in_with_github_btn = @driver.find_element(:xpath => home_signin_data[:btn_sign_in_with_github]) end
    def forgot_my_password_link 
    	@forgot_my_password_link = @driver.find_element(:xpath => @data_xpath[:sign_in_page][:i_forgot_my_password]) 
    end
    def error_message_box
        @error_message_box = @driver.find_element(:xpath => @data_xpath[:sign_in_page][:error_message]) 
    end
    def close_browser()         @driver.quit end

end
