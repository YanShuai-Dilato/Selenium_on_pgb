#encoding: utf-8

module WebdriverHelper

	def wait_for_element_present(how_long=60, how, what) 
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.find_element(how, what) } 
    end

    def wait_for_page_load(how_long=60, url)
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.current_url == url } 
        puts "wait_for_page_load"
    end

    def wait_for_page_with_title(how_long=60, title)
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.title.downcase == title.downcase}
    end

    def isElementPreset?(how_long, how, what)
        wait_for_it = Selenium::WebDriver::Wait.new(:timeout => how_long)
        wait_for_it.until { @driver.find_element(how, what) }
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

    # detect operating system (win or mac)
    def win_or_mac
        os = RUBY_PLATFORM
        if os.include? 'darwin'
            return 'mac'
        elsif os.include? 'mingw32'
            return 'win'
        else
            return 'mac'
        end
    end
    # 
    def take_screenshot_with_name name
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG'] 
        if win_or_mac == 'win'
            dir = "#{ENV['USERPROFILE']}\\Desktop\\Selenium_on_pgb\\auto_results\\#{lang}_#{browser}\\screenshots\\#{name}.png"
        elsif win_or_mac == 'mac'
            dir = "./auto_results/#{lang}_#{browser}/screenshots/#{name}.png"
        else
            puts "We do not support your Operating System right now"
        end
        @driver.save_screenshot "#{dir}" 
    end

    # for the purpose of unique email address, which was used to create new Adobe ID each time.
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