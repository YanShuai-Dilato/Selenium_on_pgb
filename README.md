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

	gem install rspec

	gem install selenium-webdriver

	gem install rake
3, Clone the repo to your local machine

	cd /Users/yourname/
	
	git clone https://github.com/YanShuai-Dilato/Selenium_on_pgb.git
	
	
### Demo 


### Output html
$ rspec ~/folderA/file.rb --format h > ./result.html


### Update details:

Folder "action" includes the logic actions

Folder "tools" includes the helper actions, such as "click". 

Folder "testcase" includes the test cases 

Folder "data" includes the util tools that read data and provide data ref

Folder "assets" includes all the data that the test cases need.
