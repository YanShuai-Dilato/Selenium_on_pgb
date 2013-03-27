require 'rake'
require 'rspec/core/rake_task'


@t = Time.now.strftime "%Y%m%d%H%M%S"

if defined? RSpec
    desc "Run the demo testcases of sign_in_rspec"
    
    RSpec::Core::RakeTask.new(:spec,:osconfig) do |t|
      # t.pattern = "./testcases/sign_in_rspec.rb"  
      t.pattern = "./testcases/new_app_rspec.rb"
      #output to html file with timeframe
      t.rspec_opts = "--format h > ./result_html/result_#{@t}.html "
      
	  #init config
      ENV['BROWSER'] = 'chrome'
   	  ENV['LANG'] = 'en_US'
    end

    desc "Run all testcases"
   
    RSpec::Core::RakeTask.new(:allspecs,:osconfig) do |t|
      t.pattern = "./testcases/*_rspec.rb"
      #output to html file with timeframe
      t.rspec_opts = "--format h > ./result_html/result_#{@t}.html "
      #init config
      ENV['BROWSER'] = 'chrome'
      ENV['LANG'] = 'en_US'
    end
end


task :default => :spec