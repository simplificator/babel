require 'test_helper'

class StringExtensionsTest < Test::Unit::TestCase
  should 'build no ngrams for empty string' do
    assert_equal [], ''.ngrams
  end
  should 'build all ngrams when no options' do 
    assert_equal ['f', 'fo', 'foo', 'o', 'oo', 'o'], 'foo'.ngrams
  end
  
  should 'downcase' do
    assert_equal ['b'], 'B'.ngrams
    assert_equal ['b'], 'B'.ngrams(:preserve_case => false)
  end
  
  should 'not downcase with :preserve_case option' do
    assert_equal ['B'], 'B'.ngrams(:preserve_case => true)
  end
  
  should 'not generate ngrams smaller than :min_length' do
    assert_equal ['tr', 'tra', 'trai', 'train', 
                  'ra', 'rai', 'rain',
                  'ai', 'ain',
                  'in',
                  ], 'Train'.ngrams(:min_length => 2)
    
  end
  
  should 'not generate ngrams larger than :max_length' do
    assert_equal ['b', 'bo',
                  'o', 'oa',
                  'a', 'at',
                  't'], 'Boat'.ngrams(:max_length => 2)
  end
  
  should 'not generate ngrams smaller than :min_length or larger than :max_length' do
    assert_equal ['tr', 'tru',
                  'ru', 'ruc',
                  'uc', 'uck',
                  'ck',
                  ], 'Truck'.ngrams(:min_length => 2, :max_length => 3)
  end
end
