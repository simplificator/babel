require 'test_helper'

class TrainTest < Test::Unit::TestCase
  
  
  should 'Build the profiles' do
   Dir[File.dirname(__FILE__) + '/../lib/data/*.txt'].each do |name|
     File.basename(name) =~ /udhr\_(.+)\.txt/
     if ['eng', 'fra', 'deu', 'spa', 'ita'].include?($1)
     #if ['deu'].include?($1)
     puts "Learning '#{$1}'"
     File.open(name, 'r') do |file|
       file.each_with_index do |line, index|
         if index > 5 # skip header. english all the time
          Babel.learn($1, line)
         end
       end
       Babel.save_profiles(:limit => 300)
       Babel.clear_profiles
     end
    end
   end
   
  end

end
