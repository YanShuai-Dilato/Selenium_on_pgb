#encoding: utf-8

# base_env.rb

module BaseEnv

    def base_url
        puts "+ base_url = http://loc.build.phonegap.com "
    	"http://loc.build.phonegap.com"     
    end
    def browser()
         
        if $browser == :chrome
            #profile = Selenium::WebDriver::Chrome::Profile.new
            #profile['intl.accept_languages'] = $lang.to_s
            puts "+ browser = chrome"
        	Selenium::WebDriver.for :chrome 
        elsif $browser == :firefox
            profile = Selenium::WebDriver::Firefox::Profile.new
            profile['intl.accept_languages'] = $lang.to_s
            puts "+ browser = firefox"
            Selenium::WebDriver.for :firefox , :profile => profile
        else
            Selenium::WebDriver.for $browser 
        end
    end  


end
