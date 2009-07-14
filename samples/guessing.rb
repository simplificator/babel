require 'rubygems'
require File.dirname(__FILE__) + '/../lib/babel'  

def guess_language(s)
  puts "i think '#{s}' is #{s.language}"
end

def show_languages(s)
  puts "Possible Languages for '#{s}': \n#{s.languages[0..2].join(', ')}"
end
 
en = 'Rainy sunday'
de = 'Regnerischer Sonntag'
fr = 'Je ne regrette rien'
sp = 'yo no soy un marinero'

texts = [en, de, fr, sp, 'lago di como']    
Babel.load_profiles

texts.each do |text|
  guess_language text
  show_languages text
end