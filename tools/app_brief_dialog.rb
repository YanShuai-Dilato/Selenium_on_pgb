

module AppBriefDialog 
  
  def article_tags_on_page 
    @article_tags ||= @driver.find_elements(:tag_name => "article")
  end
  
  def id_of_app
     @driver.find_element(:xpath => @data_xpath[:app_brief_detail][:app_id])
  end
  
  def title_of_app 
  end
  
  def desc_of_app
  end
  
  def source_of_app
    @source_of_app_by_repo ||= @driver.find_element(:xpath => @data_xpath[:new_app_detail][:source])
  end
  
end