#encoding: utf-8

module SignInDialog

    def id_textinput()     
        @driver.find_element(:xpath => @data_xpath[:sign_in_page][:adobe_id]) end
    def password_textinput()   
        @driver.find_element(:xpath => @data_xpath[:sign_in_page][:password]) end
    def sign_in_btn()           
        @driver.find_element(:xpath => @data_xpath[:sign_in_page][:btn_sign_in]) end
    def sign_in_with_github_btn()   
        @driver.find_element(:xpath => @data_xpath[:sign_in_page][:btn_sign_in_with_github]) end
    def forgot_my_password_link 
    	@driver.find_element(:xpath => @data_xpath[:sign_in_page][:i_forgot_my_password_link]) 
    end
    def forgot_password_email_input 
        @driver.find_element(:xpath => @data_xpath[:sign_in_page][:forgot_password_email])
    end
    def forgot_password_reset_btn 
        @driver.find_element(:xpath => @data_xpath[:sign_in_page][:forgot_password_reset_btn])
    end
    def didnt_receive_confirmation_link
        @driver.find_element(:xpath => @data_xpath[:sign_in_page][:didnt_rec_conf_instru_link])
    end
    def resend_confirm_instru_email_input
        @driver.find_element(:xpath => @data_xpath[:sign_in_page][:resend_confirm_instru_email])
    end
    def resend_confirm_instru_btn 
        @driver.find_element(:xpath => @data_xpath[:sign_in_page][:resend_confirm_instru_btn])
    end
    
    def error_message_box
        @error_message_box = @driver.find_element(:xpath => @data_xpath[:sign_in_page][:error_message]) 
    end

    def enter_email_address(email)
        id_textinput.send_keys(email)
    end

    def enter_password(password) 
        password_textinput.send_keys(password)
    end

    def click_sign_in
        sign_in_btn.click
    end

    def close_browser()         @driver.quit end

end
