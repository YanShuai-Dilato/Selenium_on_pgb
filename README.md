Testing_on_Phonegap_Build
===============
The project automates the I18N testing on PhonegapBuild website, using rspec, with Selenium::Webdriver(http://rubygems.org/gems/selenium-webdriver) 

### Requirement:

- git
- ruby
- rspec
- selenium-webdriver
- rake

### Setup

1, Install ruby environement on your Operating System. 

2, Install RSpec and Selenium-WebDriver package with gem

	$ gem install rspec

	$ gem install selenium-webdriver

	$ gem install rake

### Demo 

1, Clone the repo to your local machine

	$ cd /Users/yourname/
	
	$ git clone https://github.com/YanShuai-Dilato/Selenium_on_pgb.git
	
	$ cd Selenium_on_pgb/

2, Run the test 
	
	$ rake
	
3, Then you will find some related information in the terminal telling you the `position` and the `name` of the output result, like

	scott@:Selenium_on_pgb$ rake
	/usr/bin/ruby -S rspec ./testcases/sign_in_rspec.rb --format h > ./result_html/result_20130327110429.html 
	
4, You then can open it with your default browser
	
	scott@:Selenium_on_pgb$ open ./result_html/result_20130327110429.html

### Output html
$ rspec ~/folderA/file.rb --format h > ./result.html


### Update details:

Folder "action" includes the logic actions

Folder "tools" includes the helper actions, such as "click". 

Folder "testcase" includes the test cases 

Folder "data" includes the util tools that read data and provide data ref

Folder "assets" includes all the data that the test cases need.
