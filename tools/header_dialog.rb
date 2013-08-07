#encoding: utf-8

module HeaderDialog

  define_method :header_get do |xpth|
    @driver.find_element(:xpath => @data_xpath[:header][xpth]) 
  end

  define_method "go_to_page" do |which| 
    header_get("main_nav_link_#{which}".to_sym).click
  end

  def sign_out
    header_get(:account_navlink_edit).click
    header_get(:account_navlink_sign_out).click
  end

  def account_notice
    header_get(:account_notice)
  end

  def go_to_page_edit_account
    header_get(:account_navlink_edit).click
    header_get(:account_navlink_edit_account).click
  end
end