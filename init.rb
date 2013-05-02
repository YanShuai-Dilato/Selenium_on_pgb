# init.rb
# This file does some initialization works, such as
# 	Delete the results folder and create new folder for the results
#	Delete redundant apps related to testing accounts.
#	Delete pgb account 

require 'fileutils'
require 'rest_client'

def is_nil_or_empty(str)
    if str.to_s.strip.length == 0 
        return true 
    end
    return false
end

def get_value_of_env(env, default_value)
    if is_nil_or_empty(env)   
        return default_value
    else 
        return env 
    end
end

browser = get_value_of_env(ENV['PGB_BROWSER'], "chrome")
lang    = get_value_of_env(ENV['PGB_LANG'], "en_US")
	
# First delete the result folder and all subfolders recursively 
FileUtils.rm_rf('./auto_results')  

# Then to create the structure
name_sub_dir = lang + "_" + browser
Dir.mkdir("./auto_results") unless Dir.exists?("auto_results")
Dir.mkdir("./auto_results/#{name_sub_dir}") unless Dir.exists?("./auto_results/#{name_sub_dir}")
Dir.mkdir("./auto_results/#{name_sub_dir}/screenshots") unless Dir.exists?("./auto_results/#{name_sub_dir}/screenshots")
Dir.mkdir("./auto_results/#{name_sub_dir}/video") unless Dir.exists?("./auto_results/#{name_sub_dir}/video")





