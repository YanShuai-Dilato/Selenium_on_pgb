require 'yaml'
require "../tools/home_dialog"

class HomePage
    include HomeDialog

    def initialize(driver)
        @driver = driver
        @data = YAML::load(File.read("../data/data_xpath.yaml"))
    end

    def click_sign_in()      sign_in_link.click     end
    def click_register()     register_link.click    end
    def click_docs_link()    docs_link.click        end
    def click_blog_link()     blog_link.click       end
    def click_support_link() support_link.click     end
    def click_get_started()  get_started_link.click end

    def close_current_browser
        close_browser
    end
end