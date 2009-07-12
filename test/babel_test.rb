require 'test_helper'

class BabelTest < Test::Unit::TestCase
  
  
  should 'Build the profile' do
    en = "Rainy sunday afternoon"
    de = 'Regnerischer Sonntag'
    fr = 'Je ne regrette rien'
    
    
    
    
    #Babel.load_profile
    #File.open(File.dirname(__FILE__) + '/../lib/data/en.txt') do |file|
      #Babel.learn('en', file.read)
    #end
    #File.open(File.dirname(__FILE__) + '/../lib/data/de.txt') do |file|
      #Babel.learn('de', file.read)
    #end
    en.language = 'en'
    de.language = 'de'
    fr.language = 'fr'
    puts en.language
    puts de.language
    puts fr.language
    puts Babel.distances(en).inspect
    puts Babel.distances(de).inspect
    puts Babel.distances(fr).inspect
    Babel.save_profile
  end
end
