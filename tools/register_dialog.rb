#encoding: utf-8 

module RegisterDialog

	def free_plan_link()  
		@driver.find_element(:xpath => @data_xpath[:register_page][:free_plan]) 
	end
	def paid_plan_link()  
		@driver.find_element(:xpath => @data_xpath[:register_page][:paid_plan])
	end
	def contact_us_link() 
		@driver.find_element(:xpath => @data_xpath[:register_page][:contact_us])
	end

	def do_not_match_waring 
		@driver.find_element(:xpath => @data_xpath[:register_page][:do_not_match_warning]).text
	end
	def warning_existing_registration_found
		@driver.find_element(:xpath => @data_xpath[:register_page][:warning_existing_registration_found])
	end

	def adobe_id_btn()	
		@driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_btn])	
	end
	def github_btn() 
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:github_btn])
		highlight(:xpath, @data_xpath[:register_page][:github_btn])
		sleep 3 # --- remember to delete me. 
		return field 
	end

	def start_at_9_99_btn 
		@driver.find_element(:xpath => @data_xpath[:register_page][:start_at_9_99_btn])
	end
	def ccm_29_99_btn
		@driver.find_element(:xpath => @data_xpath[:register_page][:ccm_29_99_btn])
	end
	def choose_payplan_9_99_link
		@driver.find_element(:xpath => @data_xpath[:register_page][:choose_pay_plan_9_99])
	end
	def payment_continue_btn
		@driver.find_element(:xpath => @data_xpath[:register_page][:payment_continue_btn])
	end
	def payment_confirm_btn
		@driver.find_element(:xpath => @data_xpath[:register_page][:payment_confirm_btn])
	end
	def i_agree_to_the_terms_above
		@driver.find_element(:xpath => @data_xpath[:register_page][:I_agree_to_the_terms_above])
	end

	def github_login_field_username
		@driver.find_element(:xpath => "//*[@id='login_field']")
	end
	def github_login_field_password
		@driver.find_element(:xpath => "//*[@id='password']")
	end
	def github_login_field_submit
		@driver.find_element(:xpath => "/html/body/div/div[2]/div/div/form/div[3]/input[4]")
	end
	def github_login_field_authorize_app
		@driver.find_element(:xpath => "//*[@id='site-container']/div/form/div[3]/button[1]")
	end
	def github_login_field_select_a_country
		@driver.find_element(:xpath => @data_xpath[:register_page][:github_select_a_country])
	end
	def github_login_field_agree_to_the_adobe_terms
		@driver.find_element(:xpath => @data_xpath[:register_page][:github_accept_the_adobe_terms])
	end
	def github_login_field_warning_msg
		@driver.find_element(:xpath => @data_xpath[:register_page][:github_warning_message])
	end
	def github_login_field_complete_my_registration
		@driver.find_element(:xpath => @data_xpath[:register_page][:github_complete_my_registration])
	end

# -- begin adobe id iframe
	def adobe_id_frame_enter_email(email)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_adobe_id_input])		
		highlight(:xpath, @data_xpath[:register_page][:adobe_id_frame_adobe_id_input])
		sleep 5
		clear_and_type(field, email)
	end

	def adobe_id_frame_enter_password(password)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_password_input])	
		clear_and_type(field, password)
	end

	def adobe_id_frame_create_an_adobe_id_btn
		@driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_create_adobe_id_btn])
	end

	def adobe_id_frame_enter_username(username)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_adobe_id_input_2])
		clear_and_type(field, username)
	end

	def adobe_id_frame_enter_password_2(password)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_password_input_2])
		clear_and_type(field, password)
	end

	def adobe_id_frame_retype_password(retype_password)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_retype_password_input])
		clear_and_type(field, retype_password)
	end

	def adobe_id_frame_firstname_input(first_name)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_firstname_input])
		clear_and_type(field, first_name)
	end

	def adobe_id_frame_lastname_input(last_name)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_lastname_input])
		clear_and_type(field, last_name)
	end

	def adobe_id_select_country_region(region)
		country_select = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_country_region_select])
		countries = country_select.find_elements(:tag_name => "option")
		countries.each do |el| 
		    if(el.attribute("value") == region)
		        el.click
		        break
		    end
		end
	end

	def read_and_agree_the_term_checkbox
		@driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_read_and_agree_the_term_checkbox])
	end

	def accept_btn
		@driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_accept_btn])
	end

	def adobe_id_frame_sign_in_btn
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_sign_in_btn])
		highlight(:xpath, @data_xpath[:register_page][:adobe_id_frame_sign_in_btn])
		return field
	end

	def adobe_id_frame_warning_message() 
		@driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_warning_message])
	end
# -- end adobe id iframe 	

	def sign_in_btn
		@driver.find_element(:xpath => @data_xpath[:register_page][:sign_in_btn])
	end

	def read_accept_terms_checkbox
		@data_xpath[:register_page][:accept_the_term]  
	end

	def create_an_adobe_id_btn
		@driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_create_adobe_id_btn])
	end

	def create_btn
		@driver.find_element(:xpath => @data_xpath[:register_page][:create_btn])
	end

	def accept_terms()
		read_accept_terms.click
	end

	def accept_and_go_on
		accept_btn.click
	end

	def clear_and_type(field, text)
		field.clear
		puts "+ clear_and_type"
		puts "+ #{text}"
		field.send_keys(text)
	end

end