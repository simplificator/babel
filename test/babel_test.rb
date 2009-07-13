require 'test_helper'

class BabelTest < Test::Unit::TestCase
  
  
  should 'Build the profile' do
    en = "Rainy sunday"
    de = 'Regnerischer Sonntag'
    fr = 'Je ne regrette rien'
    sp = 'yo no soy un marinero'
    
    #Babel.load_profiles
    Babel.load_profile File.dirname(__FILE__) + '/../lib/profiles/profile_deu.yml'
    Babel.load_profile File.dirname(__FILE__) + '/../lib/profiles/profile_eng.yml'
    Babel.load_profile File.dirname(__FILE__) + '/../lib/profiles/profile_ita.yml'
    Babel.load_profile File.dirname(__FILE__) + '/../lib/profiles/profile_spa.yml'
    Babel.load_profile File.dirname(__FILE__) + '/../lib/profiles/profile_fra.yml'
    foo en
    foo de
    foo fr
    foo sp
    
    bar en
    bar de
    bar fr
    bar sp
    
    puts sp.languages[0..2].inspect
  end
  
  
  
  
  def foo(s)
    puts "i think '#{s}' is #{s.language}"
  end
  
  def bar(s)
    puts "Distances for '#{s}': \n#{Babel.distances(s).inspect}"
  end
  
end
