module Babel
  class Profile
    # match at least two consecutive whitespaces
    WHITESPACE_REGEXP = /\s\s+/
    # match numbers and punctuation
    CLEAN_REGEXP = /[0-9]|\.|;|:|,|-|\(|\)|\[|\]|\{|\}|\?/
    attr_reader :language
    attr_reader :data
    def initialize(language = nil)
      # key -> value: n-gram -> [occurence, weight, rank]
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
      text = clean_text(text)
      text.split(' ').each do |word|
        word.n_grams(options).each do |ngram|
          self.occured(ngram)
        end
      end
      # after learning, weight the new n-grams
      self.weigh_and_rank
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
    
    def clean_text(text)
      text = text.gsub(CLEAN_REGEXP, '')
      text = text.gsub(WHITESPACE_REGEXP, ' ')
      return text
    end
    
    # limit this profile to n items
    # profile needs to be ranked first
    def limit(boundary = 100)
      @data.reject! do |key, value|
        raise 'Please call rank() first' if value[2] == 0
        value[2] > boundary
      end
      
    end
    
    # weigh and rank the current profile
    # ngrams are sorted by occurence and then weighted (occurence / total occurence) / ranked
    # rank is currently used for limiting the profile
    def weigh_and_rank
      @data.values.sort do |o1, o2|
        o2.first <=> o1.first # sort descending by occurence
      end.each_with_index do |item, index|  
        item[1] = item[0] / @total_occurences.to_f
        item[2] = index + 1
      end
    end
    
    # Called when a n-gram is occured, optional you can pass an
    # amount (how many times the ngram occured)
    def occured(ngram, amount = 1)
      (@data[ngram] ||= [0, 0, 0])[0] += amount
      @total_occurences += amount
    end
    
    # find the occurence of a ngram. if it never occured, returns 0
    def occurence(ngram)
      ngram_data_or_zero(ngram , 0)
    end
    
    # find the weight of a ngram. if it is not yet ranked, return 0
    def weight(ngram)
      ngram_data_or_zero(ngram , 1)
    end  
    
    # find the rank
    def rank(ngram)
      ngram_data_or_zero(ngram , 2)
    end
    
    # Calculate the distance to another profile
    def distance(other)
      @data.inject(0) do |memo, item|
        other_weight = other.weight(item[0])
        if other_weight == 0
          memo += 1
        else
          memo += (other_weight - item.last[1]).abs
        end
      end
    end
    
      
    def to_s
      @data.inspect
    end
    
    private
    
    def ngram_data_or_zero(ngram, pos)
      @data[ngram] ? @data[ngram][pos] : 0
    end
      
  end
end