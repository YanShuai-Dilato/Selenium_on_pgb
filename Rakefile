require 'rake'
require 'rspec/core/rake_task'

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

# require 'fileutils'
# FileUtils.mkdir_p 'cool/beans'

if defined? RSpec

    desc "New App Free Account RSpec"
    RSpec::Core::RakeTask.new(:TC_001) do |t|
        Dir.mkdir("./auto_results") unless Dir.exists?("auto_results")
        Dir.mkdir("./auto_results/screenshots") unless Dir.exists?("./auto_results/screenshots")
        Dir.mkdir("./auto_results/video") unless Dir.exists?("./auto_results/video")

        t.pattern = "./testcases/TC_001_new_app_free_account_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format h > ./auto_results/index.html "
      
        #init config
        puts "ENV[PGB_BROWSER]: #{ENV['PGB_BROWSER']}"
        puts "ENV[PGB_LANG]: #{ENV['PGB_LANG']}"
        ENV['PGB_BROWSER'] = get_value_of_env(ENV['PGB_BROWSER'],'firefox')
        ENV['PGB_LANG'] = get_value_of_env(ENV['PGB_LANG'], 'en_US')
    end

end

task :default => :TC_001