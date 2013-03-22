# Just to verify whether some file(s) work OK or not

require 'yaml'

yml = YAML::load(File.read("data/data_xpath.yaml"))
url = YAML::load(File.read("data/data_url.yaml"))

puts yml[:sign_in_page][:i_forgot_my_password]
puts url[:forgot_your_password]
