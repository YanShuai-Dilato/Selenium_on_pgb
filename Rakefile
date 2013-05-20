#encoding: utf-8

require 'rake'
require 'rspec/core/rake_task'
require 'fileutils'

require_relative "./lib/config_param"

if defined? RSpec
    include ConfigParam

    desc "All Test Cases "
    RSpec::Core::RakeTask.new(:all_testcases) do |t|
        #init config
        browser = ENV['PGBBROWSER']
        lang = ENV['PGBLANG']
        name_subdir = "#{lang}_#{browser}" 

        initialize_params name_subdir
        
        t.pattern = "./testcases/*_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format d > ./auto_results/#{name_subdir}/all_result.txt "
      
    end

    desc "TC_001_new_app_free_account"
    RSpec::Core::RakeTask.new(:TC_001) do |t|
        #init config
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG']
        name_subdir = "#{lang}_#{browser}" 
        
        initialize_params name_subdir

        t.pattern = "./testcases/TC_001_new_app_free_account_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format d > ./auto_results/#{name_subdir}/TC_001_selenium_result.txt "
    end

    desc "TC_002_new_app_paid_account"
    RSpec::Core::RakeTask.new(:TC_002) do |t|
        #init config
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG']
        name_subdir = "#{lang}_#{browser}" 
        
        initialize_params name_subdir

        t.pattern = "./testcases/TC_002_new_app_paid_account_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format d > ./auto_results/#{name_subdir}/TC_002_selenium_result.txt "
    end

    desc "TC_003_register_create_adobe_id"
    RSpec::Core::RakeTask.new(:TC_003) do |t|
        #init config
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG']
        name_subdir = "#{lang}_#{browser}" 
        
        initialize_params name_subdir

        t.pattern = "./testcases/TC_003_register_create_adobe_id_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format d > ./auto_results/#{name_subdir}/TC_003_selenium_result.txt "
    end

    desc "TC_004_register_free_plan_adobe"
    RSpec::Core::RakeTask.new(:TC_004) do |t|
        #init config
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG']
        name_subdir = "#{lang}_#{browser}" 
        
        initialize_params name_subdir

        t.pattern = "./testcases/TC_004_register_free_plan_with_adobe_id_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format d > ./auto_results/#{name_subdir}/TC_004_selenium_result.txt "
    end

    desc "TC_005_register_free_plan_github"
    RSpec::Core::RakeTask.new(:TC_005) do |t|
        #init config
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG']
        name_subdir = "#{lang}_#{browser}" 
        
        initialize_params name_subdir

        t.pattern = "./testcases/TC_005_register_free_plan_with_github_id_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format d > ./auto_results/#{name_subdir}/TC_005_selenium_result.txt "
    end

    desc "TC_006_register_paid_ccm_rspec"
    RSpec::Core::RakeTask.new(:TC_006) do |t|
        #init config
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG']
        name_subdir = "#{lang}_#{browser}" 
        
        initialize_params name_subdir

        t.pattern = "./testcases/TC_006_register_paid_ccm_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format d > ./auto_results/#{name_subdir}/TC_006_selenium_result.txt "
    end

    desc "TC_007_register_upgrade_plan"
    RSpec::Core::RakeTask.new(:TC_007) do |t|
        #init config
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG']
        name_subdir = "#{lang}_#{browser}"

        initialize_params name_subdir
        
        t.pattern = "./testcases/TC_007_register_upgrade_plan_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format d > ./auto_results/#{name_subdir}/TC_007_selenium_result.txt "
    end

    desc "TC_008_sign_in_rspec"
    RSpec::Core::RakeTask.new(:TC_008) do |t|
        #init config
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG']
        name_subdir = "#{lang}_#{browser}" 
        
        initialize_params name_subdir

        t.pattern = "./testcases/TC_008_sign_in_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format d > ./auto_results/#{name_subdir}/TC_008_selenium_result.txt "
    end

    desc "TC_009_signing_key_add_unlock_delete_rspec"
    RSpec::Core::RakeTask.new(:TC_009) do |t|
        #init config
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG']
        name_subdir = "#{lang}_#{browser}" 
        
        initialize_params name_subdir

        t.pattern = "./testcases/TC_009_signing_key_add_and_unlock_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format d > ./auto_results/#{name_subdir}/TC_009_selenium_result.txt "
    end

    desc "TC_010_signing_key_add_unlock_delete_rspec"
    RSpec::Core::RakeTask.new(:TC_010) do |t|
        #init config
        browser = ENV['PGBBROWSER'] 
        lang = ENV['PGBLANG']
        name_subdir = "#{lang}_#{browser}" 
        
        initialize_params name_subdir

        t.pattern = "./testcases/TC_010_signing_key_add_and_build_rspec.rb"
        #output to html file with timeframe
        t.rspec_opts = "--format d > ./auto_results/#{name_subdir}/TC_010_selenium_result.txt "
    end

    desc "Only for debug purpose"
    RSpec::Core::RakeTask.new(:debug_mode) do |t|
        puts "Hi there!" 
    end

end

task :default => :all_testcases