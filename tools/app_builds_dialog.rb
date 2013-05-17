module AppBuildsDialog
# --- iOS 
    def ios_signing_key_label
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_label])
    end
    def ios_signing_key_dropdown_select
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_dropdown_select])
    end
    def ios_signing_key_title_input
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_title_input])
    end
    def ios_signing_key_choose_cert_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_choose_cert_btn])
    end
    def ios_signing_key_choose_prov_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_choose_prov_btn])
    end
    def ios_signing_key_cancel_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_cancel_btn])
    end
    def ios_signing_key_submit_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_submit_btn])
    end
    def ios_signing_key_status
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_status])
    end
    def ios_signing_key_error_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_error_btn])
    end
    def ios_signing_key_error_msg
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_error_msg])
    end
    def ios_signing_key_unlock_cert_pwd_input
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_unlock_cert_pwd_input])
    end
    def ios_signing_key_unlock_cancel_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_unlock_cancel_btn])
    end
    def ios_signing_key_unlock_submit_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:ios_signing_key_unlock_submit_btn])
    end

# --- /iOS

# --- ANDROID
    def android_signing_key_label
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_label])
    end
    def android_signing_key_dropdown_select
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_dropdown_select])
    end
    def android_signing_key_title_input
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_title_input])
    end
    def android_signing_key_alias
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_alias])
    end
    def android_signing_key_choose_keystore_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_choose_keystore_btn])
    end
    def android_signing_key_cancel_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_cancel_btn])
    end
    def android_signing_key_submit_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_submit_btn])
    end
    def android_signing_key_status
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_status])
    end
    def android_signing_key_error_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_error_btn])
    end
    def android_signing_key_error_msg
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_error_msg])
    end
    def android_signing_key_unlock_cert_pwd_input
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_unlock_cert_pwd_input])
    end
    def android_signing_key_unlock_keystore_pwd_input
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_unlock_keystore_pwd_input])
    end
    def android_signing_key_unlock_cancel_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_unlock_cancel_btn])
    end
    def android_signing_key_unlock_submit_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:android_signing_key_unlock_submit_btn])
    end
    
# --- /ANDROID

# --- BLACKBERRY 
    def blackberry_signing_key_label
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_label])
    end
    def blackberry_signing_key_dropdown_select
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_dropdown_select])
    end
    def blackberry_signing_key_title_input
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_title_input])
    end
    def blackberry_signing_key_choose_csk_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_choose_csk_btn])
    end
    def blackberry_signing_key_choose_db_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_choose_db_btn])
    end
    def blackberry_signing_key_cancel_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_cancel_btn])
    end
    def blackberry_signing_key_submit_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_submit_btn])
    end
    def blackberry_signing_key_status
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_status])
    end
    def blackberry_signing_key_error_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_error_btn])
    end
    def blackberry_signing_key_error_msg
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_error_msg])
    end
    def blackberry_signing_key_unlock_password_input
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_unlock_password_input])
    end
    def blackberry_signing_key_unlock_cancel_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:blackberry_signing_key_unlock_cancel_btn])
    end
    def balckberry_signing_key_unlock_submit_btn
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:app_builds_page][:balckberry_signing_key_unlock_submit_btn])
    end
    
# --- /BLACKBERRY

    def highlight_and_return field
        highlight field
        return field
    end
end