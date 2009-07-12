module Babel
  class Profile
    def initialize
      @profile = {}
    end
    def limit(boundary = 100)
      @profile.reject! do |key, value|
        raise 'Please call rank() first' if value.last.nil?
        boundary < value.last
      end
    end
  
  
    def rank
      @profile.values.sort do |o1, o2|
        o2.first <=> o1.first
      end.each_with_index do |item, index|
        item[1] = index + 1
      end
    end
  
    def [](key)
      @profile[key]
    end
    def[](key, value)
      @profile[key] = value
    end
    
    def occured(ngram, amount = 1)
      (@profile[ngram] ||= [0, nil])[0] += amount
    end
    
    def occurence(ngram)
      @profile[ngram] ? @profile[ngram].first : nil
    end
    
    def ranking(ngram)
      @profile[ngram] ? @profile[ngram].last : nil
    end    
    def to_s
      @profile.inspect
    end
  end
end