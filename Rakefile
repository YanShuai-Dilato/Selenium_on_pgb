require 'rake'
require 'rspec/core/rake_task'

# $global_os = ENV['OS']
# $global_lang = ENV['lang']
#@datafile = ENV["datafile"]
@t = Time.now.strftime "%Y%m%d%H%M%S"

if defined? RSpec
    desc "Run the selenium testcases in <root>/testcases"
    RSpec::Core::RakeTask.new(:spec,:osconfig) do |t|
      t.pattern = "./testcases/sign_in_rspec.rb"
      t.rspec_opts = "--format h > ./result_html/result_#{@t}.html "
      #t.rspec_opts << "datafile"
      #t.rspec_opts << "mylang=EN"
    end
end


task :default => :spec