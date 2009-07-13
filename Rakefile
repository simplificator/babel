require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "babel"
    gem.summary = %Q{Utility to guess the language of a text}
    gem.email = "info@simplificator.com"
    gem.homepage = "http://github.com/simplificator/babel"
    gem.authors = ["simplificator"]
    gem.add_dependency('ya2yaml', '>= 0.2.6')
    gem.files.exclude 'lib/data'
    #gem.files.exclude 'lib/data/*.xml'
    gem.files.include 'lib/data/*.zip'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "babel #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
require 'rubygems'
require 'zip/zip'
require 'lib/babel'

namespace :babel do
  task :unpack_data do
    dir = File.join(File.dirname(__FILE__), 'lib', 'data')
    file = File.join(dir, 'udhr_txt.zip')
    Zip::ZipFile.open(file) do |zip|
      zip.each do |entry|
        destination = File.join(dir, entry.name)
        FileUtils.mkdir_p(File.dirname(destination))
        FileUtils.rm(destination) if File.exists?(destination)
        zip.extract(entry, destination)
      end
    end
    FileUtils.cp(File.join(dir, 'udhr_deu_1996.txt'), File.join(dir, 'udhr_deu.txt'))
  end
  
  task :build_profile do
    if ENV['lang']
      lang = ENV['lang']
      file = ENV['file']
      dir = ENV['dir'] || File.dirname(__FILE__)
      skip = ENV['skip']
      limit = ENV['limit']
      unless file
        skip ||= 5 # skip header in data files. english all the time
        file = File.join(File.dirname(__FILE__), 'lib', 'data', "udhr_#{lang}.txt")
      end
      puts "Learning about #{lang} from #{file} and save it to #{dir}"
      File.open(file, 'r') do |f|
        f.each_with_index do |line, index|
          if index > skip 
           Babel.learn(lang, line)
          end
        end
      end
      Babel.save_profile(lang, :dir => dir, :limit => limit)
    end
  end
  
end

