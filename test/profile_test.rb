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
    
    profile.weigh_and_rank
    
    assert_equal 1, profile.rank('a')
    assert_equal 2, profile.rank('b')
    assert_equal 3, profile.rank('c')
    assert_equal 4, profile.rank('d')
    assert_equal 5, profile.rank('e')
  end
  
  should 'limit' do
    profile = Profile.new
    profile.occured('a', 10)
    profile.occured('b', 8)
    profile.occured('c', 5)
    profile.occured('d', 3)
    profile.occured('e', 1)
    
    profile.weigh_and_rank
    profile.limit(3)
    
    assert_equal 10, profile.occurence('a')
    assert_equal 8, profile.occurence('b')
    assert_equal 5, profile.occurence('c')
    assert_equal 0, profile.occurence('d')
    assert_equal 0, profile.occurence('e')
  end
  
  should 'find the distance to another profile' do
    # distance is based on weigh_and_rank which is a floating point number
    # hard to test. just make some comparisons with <>
    a = Profile.new
    b = Profile.new
    
    a.occured('a')
    a.weigh_and_rank # always rank when finished with occured(). distance is baed on rank

    assert_equal 0, a.distance(a), 'distance to self is 0'
    assert_equal 1, a.distance(b)
    assert_equal 0, b.distance(a)
    assert_equal 0, b.distance(b)
    
    b.occured('a')
    b.weigh_and_rank

    assert_equal 0, a.distance(a)
    assert_equal 0, a.distance(b)
    assert_equal 0, b.distance(a)
    assert_equal 0, b.distance(b)
    
    a.occured('b')
    a.occured('c')
    a.weigh_and_rank

    assert  2 < a.distance(b)
    
    a.occured('d')
    a.weigh_and_rank
   
    assert 3 < a.distance(b)
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
  
  should 'clean a text' do
    profile = Profile.new
    assert_equal '', profile.clean_text('')
    assert_equal ' ', profile.clean_text('  ')
    assert_equal ' ', profile.clean_text('   ')
    assert_equal 'hallo', profile.clean_text('1h2a3l4l5o')
    assert_equal 'no braces and brackets and curly braces', profile.clean_text('(no ({braces) [] and brackets} and curly braces[]')
    
  end
  
end
