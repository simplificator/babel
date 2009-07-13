require 'test_helper'

class BabelTest < Test::Unit::TestCase
  
  
  should 'Build the profile' do
    en = "Rainy sunday afternoon next week on monday"
    de = 'Regnerischer Sonntag'
    fr = 'Je ne regrette rien'
    
    en1 = "It won't be long"
    de1 = "Tief im westen"
    fr1 = 'Allez led bleu'
    
    
    Babel.load_profiles
    File.open(File.dirname(__FILE__) + '/../lib/data/en.txt') do |file|
#      Babel.learn('en', file.read)
    end
    File.open(File.dirname(__FILE__) + '/../lib/data/de.txt') do |file|
#      Babel.learn('de', file.read)
    end
    
    File.open(File.dirname(__FILE__) + '/../lib/data/fr.txt') do |file|
#      Babel.learn('fr', file.read)
    end
    
    en.language = 'en'
    de.language = 'de'
    fr.language = 'fr'
    puts en.language
    puts de.language
    puts fr.language
    puts "rainy afternoon".language
    puts Babel.distances("why so sad").inspect
    puts Babel.distances(de).inspect
    puts Babel.distances(fr).inspect
    #Babel.save_profiles()
  end
end
