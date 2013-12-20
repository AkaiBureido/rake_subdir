require 'rake_subdir/version'
require 'em_pessimistic'
require 'eventmachine'
require 'colorize'

$exit_status = 0
$stderr.sync = true
$stdout.sync = true

module Rake
  module DSL
    module StdErrSync
      def receive_data data
        puts data.gsub(/^/,'   ') unless data.empty?
      end
      def receive_stderr data
        puts data.gsub(/^/,'   ') unless data.empty?
      end
      def unbind
        $exit_status = get_status.exitstatus
        EventMachine.stop
      end
    end

    def rake_subdir(dirs)
      o = Rake.application.options
      options = []
      options.push "--trace" if o.trace
      options.push "--silent" if o.silent
      options.push "--ignore-deprecate" if o.ignore_deprecate
      
      option_string = options.join(" ")
 
      dirs = { dirs => '' } if dirs.class == String
      dirs.each_pair do |dir, tasks|
        subrakefile = (Pathname.new(dir) + 'Rakefile').to_s
        raise "Error #{subrakefile} does not exist" unless File.exists?(subrakefile)
        Dir.chdir(dir) do
          puts "*> Execute [#{subrakefile}] (#{tasks}) {#{option_string}}".green
          # out = %x{rake #{tasks} 2>&1}
          # puts out.gsub(/^/,'   ') unless out.empty?
          # raise "Error while executing (#{tasks}) in [#{subrakefile}]" if $?.exitstatus != 0
          EventMachine.run do
            EventMachine.add_shutdown_hook {
              raise "Error while executing [#{subrakefile}] (#{tasks})" if $exit_status != 0
            }

            EMPessimistic.popen3("rake #{tasks} #{option_string}" , StdErrSync)
          end
        end
      end
    rescue StandardError => e
      puts e
      exit(1)
    end
  end
end
