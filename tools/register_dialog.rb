
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

	def warning_message() 
		@driver.find_element(:xpath => @data_xpath[:register_page][:warning_message] )
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
		@driver.find_element(:xpath => @data_xpath[:register_page][:github_btn])
	end

	def start_at_9_99_btn 
		@driver.find_element(:xpath => @data_xpath[:register_page][:start_at_9_99])
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

	def sign_in_btn
		@driver.find_element(:xpath => @data_xpath[:register_page][:sign_in_btn])
	end

	def read_accept_terms_checkbox
		@data_xpath[:register_page][:accept_the_term]  
	end
	def accept_btn
		@data_xpath[:register_page][:accept_btn]	
	end

	def click_create_an_adobe_id_btn
		@driver.find_element(:xpath => @data_xpath[:register_page][:create_adobe_id_btn]).click
	end

	def enter_sign_in_email(email)
		@field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_input])
		clear_and_type(@field, email)
	end

	def enter_sign_in_password(password)
		@field = @driver.find_element(:xpath => @data_xpath[:register_page][:password])
		clear_and_type(@field, password)
	end

	def enter_email(email)
		@field = @driver.find_element(:id => "email_address")
		clear_and_type(@field, email)
	end

	def enter_password(password)
		@field = @driver.find_element(:id => "password")
		clear_and_type(@field, password)
	end

	def enter_retype_password(password)
		@field = @driver.find_element(:id => "retype_password")
		clear_and_type(@field, password)
	end

	def enter_first_name(first_name)
		@field = @driver.find_element(:id => "first_name")
		clear_and_type(@field, first_name)
	end

	def enter_last_name(last_name)
		@field = @driver.find_element(:id => "last_name")
		clear_and_type(@field, last_name)
	end

	def select_country_region(region)
		@country_select = @driver.find_element(:id => "country")
		countries = @country_select.find_elements(:tag_name => "option")
		countries.each do |el| 
		    if(el.attribute("value") == region)
		        el.click
		        break
		    end
		end
		# set_region(region)
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
		field.send_keys(text)
	end

end