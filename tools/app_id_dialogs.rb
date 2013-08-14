
module AppIDDialogs

  def fill_in(locator, options={})
    raise "Must pass a hash containing 'with'" if not options.is_a?(Hash) or not options.has_key?(:with)
    with = options.delete(:with)
    locator.clear
    locator.send_keys(with)
  end

  define_method :builds do |arg| 
    @driver.find_element(:xpath => @data_xpath[:app_builds_page][arg])
  end

  define_method :collaborators do |arg|
    @driver.find_element(:xpath => @data_xpath[:app_collaborators_page][arg])
  end

  define_method :settings do |arg|

  end
end