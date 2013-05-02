#encoding: utf-8 

require_relative "../lib/webdriver_helper"

module RegisterDialog
	include WebdriverHelper

	def free_plan_link()  
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:free_plan]) 
		highlight(field)
		return field
	end
	def paid_plan_link()  
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:paid_plan])
		highlight(field)
		return field
	end
	def contact_us_link() 
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:contact_us])
		highlight field
		return field
	end

	def do_not_match_waring 
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:do_not_match_warning])
		highlight field 
		return field 
	end
	def warning_existing_registration_found
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:warning_existing_registration_found])
		highlight field 
		return field 
	end

	def adobe_id_btn()	
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_btn])	
		highlight field 
		return field 
	end
	def github_btn() 
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:github_btn])
		highlight(field)
		return field 
	end

	def start_at_9_99_btn 
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:start_at_9_99_btn])
		highlight field 
		return field 
	end
	def ccm_29_99_btn
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:ccm_29_99_btn])
		highlight field 
		return field 
	end
	def choose_payplan_9_99_link
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:choose_pay_plan_9_99])
		highlight field 
		return field 
	end
	def payment_continue_btn
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:payment_continue_btn])
		highlight field 
		return field 
	end
	def payment_confirm_btn
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:payment_confirm_btn])
		highlight field 
		return field 
	end
	def i_agree_to_the_terms_above
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:I_agree_to_the_terms_above])
		highlight field 
		return field 
	end

	def github_login_field_username
		field = @driver.find_element(:xpath => "//*[@id='login_field']")
		highlight field 
		return field 
	end
	def github_login_field_password
		field = @driver.find_element(:xpath => "//*[@id='password']")
		highlight field 
		return field 
	end
	def github_login_field_submit
		field = @driver.find_element(:xpath => "/html/body/div/div[2]/div/div/form/div[3]/input[4]")
		highlight field 
		return field 
	end
	def github_login_field_authorize_app
		field = @driver.find_element(:xpath => "//*[@id='site-container']/div/form/div[3]/button[1]")
		highlight field 
		return field 
	end
	def github_login_field_select_a_country
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:github_select_a_country])
		highlight field 
		return field 
	end
	def github_login_field_agree_to_the_adobe_terms
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:github_accept_the_adobe_terms])
		highlight field 
		return field 
	end
	def github_login_field_warning_msg
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:github_warning_message])
		highlight field 
		return field 
	end
	def github_login_field_complete_my_registration
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:github_complete_my_registration])
		highlight field 
		return field 
	end

# -- begin adobe id iframe
	def adobe_id_frame_enter_email(email)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_adobe_id_input])		
		highlight field
		clear_and_type(field, email)
	end

	def adobe_id_frame_enter_password(password)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_password_input])	
		highlight field
		clear_and_type(field, password)
	end

	def adobe_id_frame_create_an_adobe_id_btn
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_create_adobe_id_btn])
		highlight field
		return field 
	end

	def adobe_id_frame_enter_username(username)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_adobe_id_input_2])
		highlight field
		clear_and_type(field, username)
	end

	def adobe_id_frame_enter_password_2(password)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_password_input_2])
		highlight field
		clear_and_type(field, password)
	end

	def adobe_id_frame_retype_password(retype_password)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_retype_password_input])
		highlight field
		clear_and_type(field, retype_password)
	end

	def adobe_id_frame_firstname_input(first_name)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_firstname_input])
		highlight field
		clear_and_type(field, first_name)
	end

	def adobe_id_frame_lastname_input(last_name)
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_lastname_input])
		highlight field
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
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_read_and_agree_the_term_checkbox])
		highlight field
		return field
	end

	def accept_btn
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_accept_btn])
		highlight field
		return field 
	end

	def adobe_id_frame_sign_in_btn
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_sign_in_btn])
		highlight(field)
		return field
	end

	def adobe_id_frame_warning_message() 
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_warning_message])
		highlight field
		return field
	end
# -- end adobe id iframe 	

	def sign_in_btn
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:sign_in_btn])
		highlight field
		return field 
	end

	def read_accept_terms_checkbox
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:accept_the_term] )
		highlight field 
		return field
	end

	def create_an_adobe_id_btn
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:adobe_id_frame_create_adobe_id_btn])
		highlight field 
		return field 
	end

	def create_btn
		field = @driver.find_element(:xpath => @data_xpath[:register_page][:create_btn])
		highlight field
		return field
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