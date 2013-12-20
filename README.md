# rake_subdir

  Rucursive gem invocation, so that chained execution of Rakefiles is possible. Much like with "make -C".
  


## Installation

Add this line to your application's Gemfile:

    gem 'rake_subdir'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rake_subdir

## Usage

The usage is fairly straightforward in your Rakefile you can now call function 
```ruby
rake_subdir "dir_path" => "tasks"
```

It will automatically pick up the Rakefile in that directory and will execute given tasks on it.

Example:
```ruby
require 'rake_subdir'

task :default => [:build]
task :build do
  rake_subdir 'somedir'
end

task :clean do
  rake_subdir 'somedir' => 'clean'
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
