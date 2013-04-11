# 
# http://stackoverflow.com/questions/14068830/multiple-should-statements-in-one-rspec-it-clause-bad-idea/14069780#14069780
# 



textbox_paste_a_git_repo.attribute('placeholder')


###


country_select = driver.find_element(:id=> "address_country")
options = country_select.find_elements(:tag_name=>"option")
options.each do |el|
    if (el.value == "USA") 
        el.select()
        break
    end
end




#
# Iterates every .rb file inside a folder and require it.
# Add it to a file
# and require the file where those .rb files were needed.

Dir[File.dirname(__FILE__) + '/dish/*.rb'].each do |file|
    require file
end

# If only we can use an unique and distinguishable name for each control. 



=begin
# http://snipplr.com/view/27992/
require 'selenium/rake/tasks'
 
selenium_jar_file_path           = 'selenium-server-1.0-beta-2/selenium-server.jar'
selenium_server_log_path         = "rc_at_#{Time.now.strftime "%C%y_%m_%d_%H%M%S"}.log"
vanilla_selenium_server_log_path = "vanilla_rc_at_#{Time.now.strftime "%C%y_%m_%d_%H%M%S"}.log"
 
desc "start a selenium-rc server that can handle SSL and cross-domain requests"
 
Selenium::Rake::RemoteControlStartTask.new("rc:proxy") do |rc|
  rc.port = 4444
  rc.timeout_in_seconds = 2 * 60
  rc.background = true
  rc.wait_until_up_and_running = true
  rc.jar_file = selenium_jar_file_path
  rc.log_to = selenium_server_log_path
  rc.additional_args << "-proxyInjectionMode"
  rc.additional_args << "-trustAllSSLCertificates"
  rc.additional_args << "-avoidProxy"
end
 
desc "start the selenium-rc server"
 
Selenium::Rake::RemoteControlStartTask.new("rc") do |rc|
  rc.port = 4444
  rc.timeout_in_seconds = 2 * 60
  rc.background = true
  rc.wait_until_up_and_running = true
  rc.jar_file = selenium_jar_file_path
  rc.log_to = vanilla_selenium_server_log_path
end
 
Selenium::Rake::RemoteControlStopTask.new("rc:stop") do |rc|
  rc.host = "localhost"
  rc.port = 4444
  rc.timeout_in_seconds = 3 * 60
end
=end


