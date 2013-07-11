#encoding: utf-8

module WebdriverHelper

    def wait_for_element_present(how_long=60, how, what) 
        puts "+ <lib><webdriver_helper> wait_for_element_present --- begin"
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.find_element(how, what) } 
        puts "+ <lib><webdriver_helper> wait_for_element_present --- end"
    end

    def wait_for_page_load(how_long=60, url)
        puts "+ <lib><webdriver_helper> wait_for_page_load --- begin"
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.current_url == url } 
        puts "+ <lib><webdriver_helper> wait_for_page_load --- end"
    end

    def wait_for_page_with_title(how_long=60, title)
        puts "+ <lib><webdriver_helper> wait_for_page_with_title --- begin"
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.title.downcase == title.downcase}
        puts "+ <lib><webdriver_helper> wait_for_page_with_title --- end"
    end

    def isElementPreset?(how_long, how, what)
        puts "+ <lib><webdriver_helper> isElementPreset? --- begin"
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.find_element(how, what) }
        puts "+ <lib><webdriver_helper> isElementPreset? --- begin"
        return true
    end

    # highlight-element suggested by https://gist.github.com/marciomazza/3086536
    def highlight(element, ancestors=0)
        @driver.execute_script("hlt = function(c) { c.style.border='solid 1px rgb(255, 16, 16)'; }; return hlt(arguments[0]);", element)
        parents = ""
        red = 255

        ancestors.times do
            parents << ".parentNode"
            red -= (12*8 / ancestors)
            @driver.execute_script("hlt = function(c) { c#{parents}.style.border='solid 1px rgb(#{red}, 0, 0)'; }; return hlt(arguments[0]);", element)
        end
        sleep 1
    end

    # detect operating system (win or mac only right now)
    def win_or_mac
        os = RUBY_PLATFORM
        if os.include? 'darwin'
            puts "+ <lib><webdriver_helper> OS: Mac OSX"
            return 'mac'
        elsif os.include? 'mingw32'
            puts "+ <lib><webdriver_helper> OS: Windows"
            return 'win'
        else
            puts "+ <lib><webdriver_helper> Sorry, we do not support your Operating-System right now"
        end
    end
     
    def take_screenshot_with_name name
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG'] 
        if win_or_mac == 'win'
            dir = Dir.pwd + "/auto_results/#{lang}_#{browser}/screenshots/#{name}.png"
            puts "+ <lib><webdriver_helper> save screenshots to #{dir}"
        elsif win_or_mac == 'mac'
            dir = "./auto_results/#{lang}_#{browser}/screenshots/#{name}.png"
            puts "+ <lib><webdriver_helper> save screenshots to #{dir}"
        else
            puts "+ <lib><webdriver_helper> Sorry, we do not support your Operating-System right now"
        end
        @driver.save_screenshot "#{dir}" 
    end

    # Helper Utility
    # Helps to delete all apps via API
    def webhelper_delete_all_apps base_url=@base_url, username, password
        private_resource = RestClient::Resource.new base_url + "/api/v1/apps" , {:user => username , :password => password , :timeout => 10}
        response = private_resource.get :accept => :json
        json =  JSON.parse(response)
        json['apps'].each do |i|
            url = base_url + i['link']
            private_resource = RestClient::Resource.new url , {:user => username , :password => password , :timeout => 10}
            response = private_resource.delete 
            puts response.to_str
        end
    end

    # Helper Utility
    # Helps to delete all signing-keys via API. 
    def webhelper_delete_all_signing_keys base_url=@base_url, username, password
        private_resource = RestClient::Resource.new base_url + "/api/v1/keys", {:user => username , :password => password , :timeout => 30}
        response = private_resource.get :accept => :json
        json =  JSON.parse(response)

        puts ""
        # delete ios signing_keys
        puts "+ Delete iOS signing-key: "
        json['keys']['ios']['all'].each do |i|
            url = base_url + i['link']
            private_resource = RestClient::Resource.new url , {:user => username , :password => password , :timeout => 30}
            response = private_resource.delete 
            puts "+   " + response.to_str
        end
        # delete android signing_keys
        puts "+ Delete Android signing-key: "
        json['keys']['android']['all'].each do |i|
            url = base_url + i['link']
            private_resource = RestClient::Resource.new url , {:user => username , :password => password , :timeout => 30}
            response = private_resource.delete 
            puts "+   " + response.to_str
        end
        # delete blackberry signing_keys
        puts "+ Delete BlackBerry signing-key: "
        json['keys']['blackberry']['all'].each do |i|
            url = base_url + i['link']
            private_resource = RestClient::Resource.new url , {:user => username , :password => password , :timeout => 30}
            response = private_resource.delete 
            puts "+   " + response.to_str
        end
    end

    # To count the each test case's 'it' block order.
    # Ultimately it is used to name the screenshot when failure happens 
    class Counter
        attr_accessor :value
        def initialize(i = 0)
            @value = i
        end
        def inc
            @value = @value.succ
        end
    end

end    