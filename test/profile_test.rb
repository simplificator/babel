require 'test_helper'

class ProfileTest < Test::Unit::TestCase
  include Babel
  should 'raise occurnce' do
      profile = Profile.new
      profile.occured('h')
      assert_equal 1, profile.occurence('h')
      profile.occured('h')
      assert_equal 2, profile.occurence('h')
      profile.occured('x')
      assert_equal 1, profile.occurence('x')
  end
  
  should 'raise occurence by value, if given' do
    profile = Profile.new
    profile.occured('a', 10)
    assert_equal 10, profile.occurence('a')
    
  end
  should 'return nil when not occured at all' do
    assert_equal nil, Profile.new.occurence('hi')
  end
  
  should 'rank' do
    profile = Profile.new
    profile.occured('b', 8)
    profile.occured('e', 1)
    profile.occured('a', 10)
    profile.occured('c', 5)
    profile.occured('d', 3)
    
    profile.rank
    
    assert_equal 1, profile.ranking('a')
    assert_equal 2, profile.ranking('b')
    assert_equal 3, profile.ranking('c')
    assert_equal 4, profile.ranking('d')
    assert_equal 5, profile.ranking('e')
  end
  
  should 'limit' do
    profile = Profile.new
    profile.occured('a', 10)
    profile.occured('b', 8)
    profile.occured('c', 5)
    profile.occured('d', 3)
    profile.occured('e', 1)
    
    profile.rank
    profile.limit(3)
    
    assert_equal 10, profile.occurence('a')
    assert_equal 8, profile.occurence('b')
    assert_equal 5, profile.occurence('c')
    assert_equal nil, profile.occurence('d')
    assert_equal nil, profile.occurence('e')
  end
  
end
