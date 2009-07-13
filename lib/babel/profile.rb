module Babel
  class Profile
    def initialize()
      @profile = {}
      @total_occurences = 0
    end
    
    def learn(text, options = {})
      options = {:min_length => 2, :max_length => 5, :pad => true}.merge(options)
      text = clean(text)
      text.split(' ').each do |word|
        ngrams = word.ngrams(options)
        ngrams.each do |ngram|
          self.occured(ngram)
        end
      end
      self.rank
      self # return self so we can chain learn commans. profile.learn('asasas').learn('asdsad')
    end
    
    
    # TODO: needed?
    def clean(text)
      return text
      text = text.gsub('?', '')
      text = text.gsub('.', '')
      text = text.gsub(';', '')
      text = text.gsub(':', '')
      text = text.gsub('(', '')
      text = text.gsub(')', '')
      text = text.gsub('/', '')
      text = text.gsub(/[0-9]*/, '')
      text = text.gsub('+', '')
      text
    end
    # limit this profile to n items
    # profile needs to be ranked first
    # do not use this if you plan to extend the profile later on
    def limit(boundary = 100)
      @profile.reject! do |key, value|
        raise 'Please call rank() first' if value.last == 0
        boundary < value.last
      end
    end
    
    # rank the current profile
    # ngrams are sorted by occurence and then ranked
    def rank
      @profile.values.sort do |o1, o2|
        o2.first <=> o1.first
      end.each_with_index do |item, index|
        item[1] = index + 1
      end
      
      @profile.values.each do |value|
        value[1] = value[0] / @total_occurences.to_f
      end
    end
    
    # Called when a ngram is occured, optional you can pass an
    # amount (how many times the ngram occured)
    def occured(ngram, amount = 1)
      (@profile[ngram] ||= [0, 0])[0] += amount
      @total_occurences += amount
    end
    
    # find the occurence of a ngram. if it never occured, returns 0
    def occurence(ngram)
      @profile[ngram] ? @profile[ngram].first : 0
    end
    
    # find the ranking of a ngram. if it is not yet ranked, return 0
    def ranking(ngram)
      @profile[ngram] ? @profile[ngram].last : 0
    end  
    
    # Calculate the distance to another profile
    def distance(other)
      @profile.inject(0) do |memo, item|
        other_ranking = other.ranking(item.first)
        if other_ranking == 0
          memo += 1
        else
          memo += (other_ranking - item.last.last).abs
        end
      end
    end
    
      
    def to_s
      @profile.inspect
    end
  end
end