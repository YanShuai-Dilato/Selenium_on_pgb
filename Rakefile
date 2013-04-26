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

if defined? RSpec

    desc "All Test Cases "
    RSpec::Core::RakeTask.new(:all_testcases) do |t|
        #init config
        browser = get_value_of_env(ENV['PGB_BROWSER'],'firefox')
        lang = get_value_of_env(ENV['PGB_LANG'], 'en_US')

        ENV['PGB_BROWSER'] = browser
        ENV['PGB_LANG'] = lang

        name_2nd_dir = "#{lang}_#{browser}"

        Dir.mkdir("./auto_results") unless Dir.exists?("auto_results")
        Dir.mkdir("./auto_results/#{name_2nd_dir}") unless Dir.exists?("./auto_results/#{name_2nd_dir}")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/screenshots") unless Dir.exists?("./auto_results/#{name_2nd_dir}/screenshots")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/video") unless Dir.exists?("./auto_results/#{name_2nd_dir}/video")


        t.pattern = "./testcases/*_rspecsss.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format h > ./auto_results/index.html "
      
    end

    desc "TC_001_new_app_free_account"
    RSpec::Core::RakeTask.new(:TC_001) do |t|
        #init config
        browser = get_value_of_env(ENV['PGB_BROWSER'],'firefox')
        lang = get_value_of_env(ENV['PGB_LANG'], 'en_US')

        ENV['PGB_BROWSER'] = browser
        ENV['PGB_LANG'] = lang

        name_2nd_dir = "#{lang}_#{browser}"

        Dir.mkdir("./auto_results") unless Dir.exists?("auto_results")
        Dir.mkdir("./auto_results/#{name_2nd_dir}") unless Dir.exists?("./auto_results/#{name_2nd_dir}")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/screenshots") unless Dir.exists?("./auto_results/#{name_2nd_dir}/screenshots")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/video") unless Dir.exists?("./auto_results/#{name_2nd_dir}/video")

        t.pattern = "./testcases/TC_001_new_app_free_account_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format h > ./auto_results/index.html "
    end

    desc "TC_002_new_app_paid_account"
    RSpec::Core::RakeTask.new(:TC_002) do |t|
        #init config
        browser = get_value_of_env(ENV['PGB_BROWSER'],'firefox')
        lang = get_value_of_env(ENV['PGB_LANG'], 'en_US')

        ENV['PGB_BROWSER'] = browser
        ENV['PGB_LANG'] = lang

        name_2nd_dir = "#{lang}_#{browser}"

        Dir.mkdir("./auto_results") unless Dir.exists?("auto_results")
        Dir.mkdir("./auto_results/#{name_2nd_dir}") unless Dir.exists?("./auto_results/#{name_2nd_dir}")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/screenshots") unless Dir.exists?("./auto_results/#{name_2nd_dir}/screenshots")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/video") unless Dir.exists?("./auto_results/#{name_2nd_dir}/video")

        t.pattern = "./testcases/TC_002_new_app_paid_account_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format h > ./auto_results/index.html "
    end

    desc "TC_003_register_create_adobe_id"
    RSpec::Core::RakeTask.new(:TC_003) do |t|
        #init config
        browser = get_value_of_env(ENV['PGB_BROWSER'],'firefox')
        lang = get_value_of_env(ENV['PGB_LANG'], 'en_US')

        ENV['PGB_BROWSER'] = browser
        ENV['PGB_LANG'] = lang

        name_2nd_dir = "#{lang}_#{browser}"

        Dir.mkdir("./auto_results") unless Dir.exists?("auto_results")
        Dir.mkdir("./auto_results/#{name_2nd_dir}") unless Dir.exists?("./auto_results/#{name_2nd_dir}")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/screenshots") unless Dir.exists?("./auto_results/#{name_2nd_dir}/screenshots")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/video") unless Dir.exists?("./auto_results/#{name_2nd_dir}/video")

        t.pattern = "./testcases/TC_003_register_create_adobe_id_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format h > ./auto_results/index.html "
    end

    desc "TC_004_register_free_plan_adobe"
    RSpec::Core::RakeTask.new(:TC_004) do |t|
        #init config
        browser = get_value_of_env(ENV['PGB_BROWSER'],'firefox')
        lang = get_value_of_env(ENV['PGB_LANG'], 'en_US')

        ENV['PGB_BROWSER'] = browser
        ENV['PGB_LANG'] = lang

        name_2nd_dir = "#{lang}_#{browser}"

        Dir.mkdir("./auto_results") unless Dir.exists?("auto_results")
        Dir.mkdir("./auto_results/#{name_2nd_dir}") unless Dir.exists?("./auto_results/#{name_2nd_dir}")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/screenshots") unless Dir.exists?("./auto_results/#{name_2nd_dir}/screenshots")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/video") unless Dir.exists?("./auto_results/#{name_2nd_dir}/video")

        t.pattern = "./testcases/TC_004_register_free_plan_adobe_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format h > ./auto_results/index.html "
    end

    desc "TC_005_register_free_plan_github"
    RSpec::Core::RakeTask.new(:TC_005) do |t|
        #init config
        browser = get_value_of_env(ENV['PGB_BROWSER'],'firefox')
        lang = get_value_of_env(ENV['PGB_LANG'], 'en_US')

        ENV['PGB_BROWSER'] = browser
        ENV['PGB_LANG'] = lang

        name_2nd_dir = "#{lang}_#{browser}"

        Dir.mkdir("./auto_results") unless Dir.exists?("auto_results")
        Dir.mkdir("./auto_results/#{name_2nd_dir}") unless Dir.exists?("./auto_results/#{name_2nd_dir}")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/screenshots") unless Dir.exists?("./auto_results/#{name_2nd_dir}/screenshots")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/video") unless Dir.exists?("./auto_results/#{name_2nd_dir}/video")

        t.pattern = "./testcases/TC_005_register_free_plan_github_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format h > ./auto_results/index.html "
    end

    desc "TC_006_register_paid_ccm_rspec"
    RSpec::Core::RakeTask.new(:TC_006) do |t|
        #init config
        browser = get_value_of_env(ENV['PGB_BROWSER'],'firefox')
        lang = get_value_of_env(ENV['PGB_LANG'], 'en_US')

        ENV['PGB_BROWSER'] = browser
        ENV['PGB_LANG'] = lang

        name_2nd_dir = "#{lang}_#{browser}"

        Dir.mkdir("./auto_results") unless Dir.exists?("auto_results")
        Dir.mkdir("./auto_results/#{name_2nd_dir}") unless Dir.exists?("./auto_results/#{name_2nd_dir}")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/screenshots") unless Dir.exists?("./auto_results/#{name_2nd_dir}/screenshots")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/video") unless Dir.exists?("./auto_results/#{name_2nd_dir}/video")

        t.pattern = "./testcases/TC_006_register_paid_ccm_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format h > ./auto_results/index.html "
    end

    desc "TC_007_register_upgrade_plan"
    RSpec::Core::RakeTask.new(:TC_007) do |t|
        #init config
        browser = get_value_of_env(ENV['PGB_BROWSER'],'firefox')
        lang = get_value_of_env(ENV['PGB_LANG'], 'en_US')

        ENV['PGB_BROWSER'] = browser
        ENV['PGB_LANG'] = lang

        name_2nd_dir = "#{lang}_#{browser}"

        Dir.mkdir("./auto_results") unless Dir.exists?("auto_results")
        Dir.mkdir("./auto_results/#{name_2nd_dir}") unless Dir.exists?("./auto_results/#{name_2nd_dir}")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/screenshots") unless Dir.exists?("./auto_results/#{name_2nd_dir}/screenshots")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/video") unless Dir.exists?("./auto_results/#{name_2nd_dir}/video")

        t.pattern = "./testcases/TC_007_register_upgrade_plan_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format h > ./auto_results/index.html "
    end

    desc "TC_008_sign_in_rspec"
    RSpec::Core::RakeTask.new(:TC_008) do |t|
        #init config
        browser = get_value_of_env(ENV['PGB_BROWSER'],'firefox')
        lang = get_value_of_env(ENV['PGB_LANG'], 'en_US')

        ENV['PGB_BROWSER'] = browser
        ENV['PGB_LANG'] = lang

        name_2nd_dir = "#{lang}_#{browser}"

        Dir.mkdir("./auto_results") unless Dir.exists?("auto_results")
        Dir.mkdir("./auto_results/#{name_2nd_dir}") unless Dir.exists?("./auto_results/#{name_2nd_dir}")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/screenshots") unless Dir.exists?("./auto_results/#{name_2nd_dir}/screenshots")
        Dir.mkdir("./auto_results/#{name_2nd_dir}/video") unless Dir.exists?("./auto_results/#{name_2nd_dir}/video")

        t.pattern = "./testcases/TC_008_sign_in_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format h > ./auto_results/index.html "
    end

end

task :default => :all_testcases