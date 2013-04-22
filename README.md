Testing_on_Phonegap_Build
===============
The project automates the I18N testing on PhonegapBuild website, using rspec, with Selenium::Webdriver(http://rubygems.org/gems/selenium-webdriver) 

### Requirement:

- git
- ruby
- rspec
- selenium-webdriver
- rake
- rest-client

### Setup

1, Install ruby environement on your Operating System. 

2, Install RSpec, Selenium-WebDriver, and rake packages with gem

    $ gem install rspec

	$ gem install selenium-webdriver

	$ gem install rake
	
	$ gem install rest-client

### Deploy manually 

1, Clone the repo to your local machine
	
	$ git clone https://github.com/YanShuai-Dilato/Selenium_on_pgb.git
	
	$ cd Selenium_on_pgb/

2, Manage testing task in Rakefile

   example:
	
    RSpec::Core::RakeTask.new(:spec,:osconfig) do |t|
      t.pattern = "./testcases/sign_in_rspec.rb"  
      #output to html file with timeframe
      t.rspec_opts = "--format h > ./result_html/result_#{@t}.html "
      
	  #init config
      ENV['BROWSER'] = 'chrome'
      ENV['LANG'] = 'en_US'
    end
    ------
    * Set testing browser for ENV['BROWSER'] . Support 'chrome , firefox ,ie ...' . Full support can be found at http://docs.seleniumhq.org/docs/03_webdriver.jsp
    * Set the locale for ENV['LANG'].By now , en_US , fr_FR, ja_JP are available.
    * Manage the running testcases for 't.pattern'.
    
3, Run the test 
	
	$ rake
	* Run default task
	$ rake :taskname
	* Run specific task
	

	
4, You then can open it with your default browser
	
	$ open ./result_html/result_<the timeframe>.html
	
	

### Code structure
<root>/selenium_Logical_view_Draft.png


### Test cases 


new_app_free_account_rspec.rb

new_app_paid_account_rspec.rb

register_create_adobe_id_rspec.rb

register_free_plan_adobe_rspec.rb

register_free_plan_github_rspec.rb

register_upgrade_plan_spec.rb

sign_in_rspec.rb
