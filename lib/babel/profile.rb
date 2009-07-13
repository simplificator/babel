module Babel
  class Profile
    attr_reader :language
    attr_reader :data
    def initialize(language = nil)
      @data = {}
      @total_occurences = 0
      @language = language
    end
    
    
    # learn a text
    # following options are used when generating the n-grams:
    #  * min_length => 2
    #  * max_length => 5
    #  * pad => true
    def learn(text, options = {})
      options = {:min_length => 2, :max_length => 5, :pad => true}.merge(options)
      text = clean(text)
      text.split(' ').each do |word|
        word.n_grams(options).each do |ngram|
          self.occured(ngram)
        end
      end
      # after learning rank the new n-grams
      self.rank
      self # return self so we can chain learn commans. profile.learn('asasas').learn('asdsad')
    end
    
    
    def merge(other)
      if self.language != other.language
        raise ArgumentError.new("self has a language of #{self.language} but profile to merge has #{other.language}")
      end
      other.data.each do |key, value|
        self.occured(key, value.first)
      end
    end
    
    # TODO: needed?
    def clean(text)
      return text
      text = text.gsub(/[0-9]/, '')
      text = text.gsub(':', '')
      text = text.gsub('/', '')
      text = text.gsub('_', '')
      text = text.gsub('(', '')
      text = text.gsub(')', '')
      text = text.gsub(';', '')
      text = text.gsub('?', '')
      
      return text
    end
    
    # limit this profile to n items
    # profile needs to be ranked first
    def limit(boundary = 100)
      @data.reject! do |key, value|
        raise 'Please call rank() first' if value.last == 0
        boundary < value.last
      end
    end
    
    # rank the current profile
    # ngrams are sorted by occurence and then ranked
    def rank
      #@data.values.sort do |o1, o2|
      #  o2.first <=> o1.first
      #end.each_with_index do |item, index|
      #  item[1] = index + 1
      #end
      
      @data.values.each do |value|
        value[1] = value[0] / @total_occurences.to_f
      end
    end
    
    # Called when a n-gram is occured, optional you can pass an
    # amount (how many times the ngram occured)
    def occured(ngram, amount = 1)
      (@data[ngram] ||= [0, 0])[0] += amount
      @total_occurences += amount
    end
    
    # find the occurence of a ngram. if it never occured, returns 0
    def occurence(ngram)
      @data[ngram] ? @data[ngram].first : 0
    end
    
    # find the ranking of a ngram. if it is not yet ranked, return 0
    def ranking(ngram)
      @data[ngram] ? @data[ngram].last : 0
    end  
    
    # Calculate the distance to another profile
    def distance(other)
      @data.inject(0) do |memo, item|
        other_ranking = other.ranking(item.first)
        if other_ranking == 0
          memo += 1
        else
          memo += (other_ranking - item.last.last).abs
        end
      end
    end
    
      
    def to_s
      @data.inspect
    end
  end
end