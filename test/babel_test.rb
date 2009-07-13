require 'test_helper'

class BabelTest < Test::Unit::TestCase
  
  
  should 'Build the profile' do
    en = "Rainy sunday afternoon next week on monday."
    de = 'Regnerischer Sonntag. Ich werde essen gehen'
    fr = 'Je ne regrette rien'
    sp = 'Yo no soy un marinero'
    
    Babel.load_profiles

    foo en
    foo de
    foo fr
    foo sp
    
    bar en
    bar de
    bar fr
    bar sp
    
  end
  
  
  
  
  def foo(s)
    puts "i think '#{s}' is #{s.language}"
  end
  
  def bar(s)
    puts "Distances for '#{s}': \n#{Babel.distances(s).inspect}"
  end
  
end
