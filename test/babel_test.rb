require 'test_helper'

class BabelTest < Test::Unit::TestCase
  
  
  should 'Build the profile' do
    en = "Rainy sunday afternoon"
    de = 'Regnerischer Sonntag'
    fr = 'Je ne regrette rien'
    
    #en.language = 'en'
    #en.language = 'de'
    #en.language = 'fr'
    Babel.load_profiles
    puts en.language
    puts de.language
    puts fr.language(:treshold => 25)
    puts Babel.distances(fr).inspect
    Babel.save_profiles
  end
end
