
module RegisterDialog

	def free_plan_link()  @data_xpath[:register_page][:free_plan]  end
	def paid_plan_link()  @data_xpath[:register_page][:paid_plan]  end
	def contact_us_link() @data_xpath[:register_page][:contact_us] end

	def warning_message() 
		@driver.find_element(:xpath => @data_xpath[:register_page][:warning_message] )
	end
	def do_not_match_waring 
		@driver.find_element(:xpath => @data_xpath[:register_page][:do_not_match_warning]).text
	end

	def adobe_id_btn()	@data_xpath[:register_page][:adobe_id_btn]	end
	def github_btn() @data_xpath[:register_page][:github_btn] end

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
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@driver.find_element(:xpath => @data_xpath[:register_page][:github_select_a_country])
	end
	def github_login_field_agree_to_the_adobe_terms
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@driver.find_element(:xpath => @data_xpath[:register_page][:github_accept_the_adobe_terms])
	end
	def github_login_field_warning_msg
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@driver.find_element(:xpath => @data_xpath[:register_page][:github_warning_message])
	end
	def github_login_field_complete_my_registration
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@driver.find_element(:xpath => @data_xpath[:register_page][:complete_my_registration])
	end

	def sign_in_btn() 
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@driver.find_element(:xpath => @data_xpath[:register_page][:sign_in_btn])
	end

	def read_accept_terms_checkbox() 
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@data_xpath[:register_page][:accept_the_term]  
	end
	def accept_btn()	
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@data_xpath[:register_page][:accept_btn]	
	end

	def click_create_an_adobe_id_btn
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@driver.find_element(:xpath => @data_xpath[:register_page][:create_adobe_id_btn]).click
	end

	def enter_email(email)
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@field = @driver.find_element(:xpath => @data_xpath[:register_page][:email_address])
		clear_and_type(@field, email)
	end

	def enter_password(password)
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@field = @driver.find_element(:xpath => @data_xpath[:register_page][:password])
		clear_and_type(@field, password)
	end

	def enter_retype_password(password)
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@field = @driver.find_element(:xpath => @data_xpath[:register_page][:retype_password])
		clear_and_type(@field, password)
	end

	def enter_first_name(first_name)
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@field = @driver.find_element(:xpath => @data_xpath[:register_page][:first_name])
		clear_and_type(@field, first_name)
	end

	def enter_last_name(last_name)
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@field = @driver.find_element(:xpath => @data_xpath[:register_page][:last_name])
		clear_and_type(@field, last_name)
	end

	def select_country_region(region)
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
		@country_select = @driver.find_element(:xpath => @data_xpath[:register_page][:country_region])
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
		@data_xpath ||= YAML::load(File.read(File.expand_path("../../data/data_xpath.yml",__FILE__)))
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