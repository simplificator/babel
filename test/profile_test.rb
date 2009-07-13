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
  should 'return 0 when not occured at all' do
    assert_equal 0, Profile.new.occurence('hi')
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
    assert_equal 0, profile.occurence('d')
    assert_equal 0, profile.occurence('e')
  end
  
  should 'find the distance to another profile' do
    a = Profile.new
    b = Profile.new
    
    a.occured('a')
    a.rank # always rank when finished with occured(). distance is baed on rank

    assert_equal 0, a.distance(a), 'distance to self is 0'
    assert_equal 1, a.distance(b)
    assert_equal 0, b.distance(a)
    assert_equal 0, b.distance(b)
    
    b.occured('a')
    b.rank

    assert_equal 0, a.distance(a)
    assert_equal 0, a.distance(b)
    assert_equal 0, b.distance(a)
    assert_equal 0, b.distance(b)
    
    a.occured('b')
    a.occured('c')
    a.rank

    assert_equal 5, a.distance(b)
    
    a.occured('d')
    a.rank
    
    # rank 4 is limited to 3 -> 8 = 2 + 3 + [4, 3].min
    assert_equal 8, a.distance(b)
  end
  
  should 'learn a text' do
    profile = Profile.new
    profile.learn('meme')
    
    assert_equal 0, profile.occurence('m')
    assert_equal 0, profile.occurence('e')
    
    assert_equal 2, profile.occurence('me')
    assert_equal 1, profile.occurence('mem')
    assert_equal 1, profile.occurence('meme')
  end
  
end
