#encoding: utf-8

require_relative "../lib/webdriver_helper"

module NewAppDialog
    include WebdriverHelper

    # 
    # new_app_btn close_link first_app_id opensource_repo_tab private_repo_tab paste_git_repo_input 
    # connect_your_github_account_link not_a_valid_github_url upload_a_zip_btn upgrade_now_link
    # ready_to_build_btn rebuild_all_btn builds_tab collaborators_tab settings_tab
    #
    define_method :newappdialog_get do |xpth| 
        highlight_and_return @driver.find_element(:xpath => @data_xpath[:sign_in_succ_page][xpth]) 
    end

    def highlight_and_return field
        highlight field
        return field
    end
end

