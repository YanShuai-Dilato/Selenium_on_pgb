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
	$ gem install rest-client

### Deploy manually 

1, Clone the repo to your local machine
	
	$ git clone https://github.com/YanShuai-Dilato/Selenium_on_pgb.git
	$ cd Selenium_on_pgb/

2, Please copy 'Selenium_on_pgb/assets/application/anotherあ你äōҾӲ.zip' to C:\ , if you're using Windows to run this test. 


3, Manage testing task in Rakefile

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
    
4, Run the test 
	
	$ rake
	* Run default task
	$ rake :taskname
	* Run specific task
	

	
5, Then you can find the result file (log.txt) at the following directory. 
	
	$ open ./auto_results/#{lang}_#{browser}/log.txt
	
	

### Code structure
https://www.dropbox.com/s/fd9cvodechaj26l/selenium_Logical_view_Draft.png


### Test cases 


TC_001_new_app_free_account_rspec()

TC_002_new_app_paid_account_rspec

TC_003_register_create_adobe_id_rspec

TC_004_register_free_plan_adobe_rspec

TC_005_register_free_plan_github_rspec

TC_006_register_paid_ccm_rspec

TC_007_register_upgrade_plan_rspec

TC_008_sign_in_rspec

