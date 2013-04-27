#encoding: utf-8

require 'rubygems'
require 'getoptlong'
require 'yaml'
require_relative '../data/base_env'

module ConfigParam
    include BaseEnv
    #used for initialize the global variable 
    def init
        $browser = ENV['PGBBROWSER'].to_sym
        $lang = ENV['PGBLANG'].to_sym

        # liclu:original function 
        # opts = GetoptLong.new(
        #   [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
        #   [ '--port', '-p', GetoptLong::REQUIRED_ARGUMENT ],
        #   [ '--browser', '-b', GetoptLong::REQUIRED_ARGUMENT ],
        #   [ '--lang', '-l', GetoptLong::REQUIRED_ARGUMENT ],
        #   [ '--config', '-c', GetoptLong::REQUIRED_ARGUMENT ],
        #   [ '--test-set', '-t', GetoptLong::REQUIRED_ARGUMENT ],
        #   [ '--skip-sections', '-s', GetoptLong::REQUIRED_ARGUMENT ],
        #   [ '--debug', '-D', GetoptLong::NO_ARGUMENT ]
        # )

        # $config = {}
        # $config['port'] = 4444
        # $config['browser'] = 'firefox'
        # $config['lang'] = 'en_us'
        # $config['test_set'] = nil
        # $config['config'] = {}
        # $config['skip'] = nil
        # $config['debug'] = false

        # Override defaults with values from config file
        #$config.merge!( File.open( "yaml/runtest.yaml" ) { |yf| YAML::load( yf ) } )

        # def usage
        #   puts <<-EOF
          
        # ./runtest [optional arguments]

        # Optional Arguments:

        #   --port/-p		port to reach selenium on; default: #{$config['port']}
        #   --browser/-b		browser; default: #{$config['browser']}
        #   --config/-c		directly overrides values in $yaml_data; format is "foo=bar"; default: #{$config['config']}
        #   --lang/-l     set the languages of browser; default: #{$config['lang']}
        #   --test-set/-t         test set to run; correspondes to a yaml/000*.yaml file generally; default: #{$config['test_set']}
        #   --skip-sections/-s	tests to skip; example: "BasicSearch,Lucky"; see the yaml/000*.yaml files for section lists (same as the file names without ".rb" in tests/); default: #{$config['skip'].to_s}
        #   --debug/-D		debug mode; default #{$config['debug']}

        #   EOF

        #   exit 1
        # end

        # opts.each do |opt, arg|
        #   case opt
        #     when '--help'
        #       usage
        #     when '--debug'
        #       $config['debug'] = true
        #     when '--port'
        #       $config['port'] = arg
        #     when '--browser'
        #       $config['browser'] = arg
        #     when '--test-set'
        #       $config['test_set'] = arg
        #     when '--config'
        #       $config['config'][arg.split(/=/, 2)[0]] = arg.split(/=/, 2)[1]
        #     when '--skip-sections'
        #       $config['skip'] = arg
        #   end
        # end

        # ENV['PORT']=$config['port'].to_s
        # ENV['BROWSER']=$config['browser'].to_s
        # ENV['LANG']=$config['lang'].to_s
        # ENV['SKIP']=$config['skip'].to_s
        # ENV['TEST_SET']=$config['test_set'].to_s
        # ENV['CONFIG']=YAML::dump($config['config'])
        # ENV['DEBUG']=$config['debug'].to_s

        # $browser = $config['browser'].to_sym

        # if $config['debug']
        #   # print "env: "+ENV.inspect+"\n"
        #   exec( "rlwrap", "rspec", "#{$0}/../wrapper.rb" )
        # else
        #   exec( "rspec", "#{$0}/../wrapper.rb" )
        # end
    end 

    #Path formattor with locale
    def path_format_locale (path)
        @base_url+path+"?locale="+$lang.to_s
    end 

end  




