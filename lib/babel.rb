if RUBY_VERSION < '1.9'
  require 'jcode'
  $KCODE = 'u'
end

require File.dirname(__FILE__) + '/babel/string_extensions'
require File.dirname(__FILE__) + '/babel/babel'
require File.dirname(__FILE__) + '/babel/profile'

require 'ya2yaml'
