require 'test_helper'

class BabelTest < Test::Unit::TestCase
  
  
  should 'Build the profile' do
    en = "Rainy sunday afternoon"
    de = 'Regnerischer Sonntag'
    fr = 'Je ne regrette rien'
    
    Babel.load_profile
    #en.language = 'en'
    #de.language = 'de'
    #fr.language = 'fr'
    puts en.language
    puts de.language
    puts fr.language
    #Babel.save_profile
  end
end
