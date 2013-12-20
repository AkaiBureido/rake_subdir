require "subrakr/version"

module Rake
  module DSL
    def rake_subdir(dirs)
      dirs = { dirs => '' } if dirs.class == String
      dirs.each_pair do |dir, tasks|
        subrakefile = (Pathname.new(dir) + 'Rakefile').to_s
        raise "Error #{subrakefile} does not exist" unless File.exists?(subrakefile)
        Dir.chdir(dir) do
          puts "-> Executing [#{subrakefile}] (#{tasks})"
          out = %x{rake #{tasks} 2>&1}
          puts out.gsub(/^/,'   ') unless out.empty?
          raise "Error while executing (#{tasks}) in [#{subrakefile}]" if $?.exitstatus != 0
        end
      end
    rescue StandardError => e
      puts e
      exit(1)
    end
  end
end
