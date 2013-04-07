
module RegisterDialog
	def free_plan_link()  @data_xpath[:register_page][:free_plan]  end
	def paid_plan_link()  @data_xpath[:register_page][:paid_plan]  end
	def contact_us_link() @data_xpath[:register_page][:contact_us] end

	def warning_message() @data_xpath[:register_page][:warning_message] end

	# Free plan
	def adobe_id_btn()	@data_xpath[:register_page][:adobe_id_btn]	end
	def github_btn() @data_xpath[:register_page][:github_btn] end
	def email_txt() @data_xpath[:register_page][:email_address] end
	def password_txt() @data_xpath[:register_page][:password] end
	def retype_password_txt() @data_xpath[:register_page][:retype_password] end
	def first_name_txt() @data_xpath[:register_page][:first_name] end
	def last_name_txt() @data_xpath[:register_page][:last_name] end 
	def region_dropdown_list() @data_xpath[:register_page][:country_region] end

	def read_accept_terms_checkbox() @data_xpath[:register_page][:accept_the_term]  end
	def accept_btn()	@data_xpath[:register_page][:accept_btn]	end
	# Paid plan

	# Interfaces
	def enter_user_information(user)
		enter_email(user[:email])
		enter_password(user[:password])
		enter_retype_password(user[:password])
		enter_first_name(user[:first_name])
		enter_last_name(user[:last_name])
		enter_country_region(user[:region])
	end

	def create
		create_adobe_id_btn.click
	end

	def enter_email(email)
		@field = @driver.find_element(:xpath => email_txt)
		clear_and_type(@field, email)
	end

	def enter_password(password)
		@field = @driver.find_element(:xpath => password_txt)
		clear_and_type(@field, password)
	end

	def enter_retype_password(password)
		@field = @driver.find_element(:xpath => retype_password_txt)
		clear_and_type(@field, password)
	end

	def enter_first_name(first_name)
		@field = @driver.find_element(:xpath => first_name_txt)
		clear_and_type(@field, first_name)
	end

	def enter_last_name(last_name)
		@field = @driver.find_element(:xpath => last_name_txt)
		clear_and_type(@field, last_name)
	end

	def enter_country_region(region)
		@field = @driver.find_element(:xpath => region_dropdown_list)
		raise RegionNotInTheListError unless region_in_the_list?
		set_region(region)
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

	def get_warning_message
		warning_message.text
	end

	def get_all_fields
		@fields << @driver.find_element(:xpath => email_txt)
		@fields << @driver.find_element(:xpath => password_txt)
		@fields << @driver.find_element(:xpath => retype_password_txt)
		@fields << @driver.find_element(:xpath => first_name_txt)
		@fields << @driver.find_element(:xpath => last_name_txt)
	end

	def region_in_the_list?(region)
		
	end

	class RegionNotInTheListError < StandardError; end 

end