#encoding: utf-8
# https://buildstage.phonegap.com/apps/_id/settings

module SettingsDialog
	
	def app_title
		@app_title ||= @driver.find_element(:xpath => @data_xpath[:app_detail_page][:settings][:configuration][:title])
	end

	def app_description
		@app_description ||= @driver.find_element(:xpath => @data_xpath[:app_detail_page][:settings][:configuration][:description])
	end

	def app_package
		@app_package ||= @driver.find_element(:xpath => @data_xpath[:app_detail_page][:settings][:configuration][:package])
	end

	def app_version
		@app_version ||= @driver.find_element(:xpath => @data_xpath[:app_detail_page][:settings][:configuration][:version])
	end

	def app_configuration
		@app_configuration ||= @driver.find_element(:xpath => @data_xpath[:app_detail_page][:settings][:configuration][:configuration])
	end

	def setting_save
		@setting_save ||= @driver.find_element(:xpath => @data_xpath[:app_detail_page][:settings][:configuration][:save])
	end

end