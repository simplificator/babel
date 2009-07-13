require 'test_helper'

class StringExtensionsTest < Test::Unit::TestCase
  # TODO: test with padding
  
  should 'build no ngrams for empty string' do
    assert_equal [], ''.n_grams
  end
  should 'build all ngrams when no options' do 
    assert_equal ['f', 'fo', 'foo', 'o', 'oo', 'o'], 'foo'.n_grams
  end
  
  should 'downcase' do
    assert_equal ['b'], 'B'.n_grams
    assert_equal ['b'], 'B'.n_grams(:preserve_case => false)
  end
  
  should 'not downcase with :preserve_case option' do
    assert_equal ['B'], 'B'.n_grams(:preserve_case => true)
  end
  
  should 'not generate ngrams smaller than :min_length' do
    assert_equal ['tr', 'tra', 'trai', 'train', 
                  'ra', 'rai', 'rain',
                  'ai', 'ain',
                  'in',
                  ], 'Train'.n_grams(:min_length => 2)
    
  end
  
  should 'not generate ngrams larger than :max_length' do
    assert_equal ['b', 'bo',
                  'o', 'oa',
                  'a', 'at',
                  't'], 'Boat'.n_grams(:max_length => 2)
  end
  
  should 'not generate ngrams smaller than :min_length or larger than :max_length' do
    assert_equal ['tr', 'tru',
                  'ru', 'ruc',
                  'uc', 'uck',
                  'ck',
                  ], 'Truck'.n_grams(:min_length => 2, :max_length => 3)
  end
end
