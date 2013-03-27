# helper method for verify the new-created app's details
# the details include: 
#     title
#     description
#     version
#     source

module AppBeingCreated 
  
  # verify whether the app's title equals to the designated string. 
  def title_of_app_by_zip 
    # Hello Worldéèàù
  end
  
  # verify whether the app's source equals to the app's github repo address. 
  def source_of_app_by_repo
    @actual_text = @driver.find_element(:xpath => @data_xpath[:new_app_detail][:source]).text + "\n"
  end
  
  #
  # will add more test cases to verify the other properties.
  #
end