#encoding: utf-8

module BaseEnv

    def base_url
    	base_url = "http://loc.build.phonegap.com" 
        puts "+ <data>/base_env.rb base_url = #{base_url}"
        return base_url  
    end
    def browser()     
        if $browser == :chrome
            #profile = Selenium::WebDriver::Chrome::Profile.new
            #profile['intl.accept_languages'] = $lang.to_s
            puts "+ <data>/base_env.rb browser = chrome"
        	Selenium::WebDriver.for :chrome 
        elsif $browser == :firefox
            profile = Selenium::WebDriver::Firefox::Profile.new
            profile['intl.accept_languages'] = $lang.to_s
            puts "+ <data>/base_env.rb browser = firefox"
            Selenium::WebDriver.for :firefox , :profile => profile
        else
            Selenium::WebDriver.for $browser 
        end
    end  

end
