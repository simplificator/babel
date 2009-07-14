require 'test_helper'

class BabelTest < Test::Unit::TestCase
  should 'identify the language' do
    Babel.load_profiles
    assert_equal 'deu', 'ich gehe essen'.language
    assert_equal 'deu', 'guten morgen'.language
    assert_equal 'deu', 'öäü'.language # :-)
    assert_equal 'deu', 'du bist der jackpot meines lebens'.language
    
    assert_equal 'eng', 'imagine there\'s no heaven'.language
    assert_equal 'eng', 'then there was you'.language
    assert_equal 'eng', 'small step for me'.language
    assert_equal 'eng', 'let there'.language
    
    assert_equal 'fra', 'le coq est mort'.language
    assert_equal 'fra', 'garçon'.language
    assert_equal 'fra', 'je ne sais pas'.language
    
    assert_equal 'spa', 'yo no soy un marinero'.language
    assert_equal 'spa', 'mucho gusto'.language
    assert_equal 'ita', 'lago di como'.language
  end
  
  should 'have a test' do
   #fail
  end
  
  should 'not choke when registering the first' do
    #puts "abc".n_grams(:pad => true)
  end
  
end
