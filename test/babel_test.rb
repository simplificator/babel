require 'test_helper'

class BabelTest < Test::Unit::TestCase
  
  
  should 'Build the profile' do
    en = "Rainy sunday afternoon next week on monday."
    de = 'Regnerischer Sonntag. Ich werde essen gehen'
    fr = 'Je ne regrette rien'
    
    en1 = "It won't be long"
    de1 = "Tief im westen"
    fr1 = 'Allez les bleu'
    
    
    Babel.load_profiles

    foo en
    foo de
    foo fr
    foo "rainy afternoon"
    
    bar en
    bar de
    bar fr
    
    #puts Babel.distances("why so sad").inspect
    #puts Babel.distances(de).inspect
    #puts Babel.distances(fr).inspect
#    Babel.save_profiles()
  end
  
  
  
  
  def foo(s)
    puts "i think '#{s}' is #{s.language}"
  end
  
  def bar(s)
    puts "Distances for '#{s}': \n#{Babel.distances(s).inspect}"
  end
  
end
