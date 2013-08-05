#encoding: utf-8

require_relative "../lib/webdriver_helper"

module FooterDialog
  include WebdriverHelper

  LANGS = {
    :english => "en_US",
    :french => "fr_FR",
    :japanese => "ja_JP",
    :chinese => "zh_CN"
  }

  define_method :footer_change_language_to do |lang|
    lang_select = @driver.find_element(:xpath => @data_xpath[:footer][:nav_select_locale])
    languages = country_select.find_elements(:tag_name => "option")
    languages.each do |la| 
        if(la.attribute("value") == LANGS[lang.to_sym])
            la.click
            break
        end
    end
  end

end