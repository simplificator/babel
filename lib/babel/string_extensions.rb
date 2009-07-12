class String 
  def ngrams(options = {})
    min_length = options[:min_length] || 1
    max_length = options[:max_length] || self.length
    value = options[:preserve_case] ? self : self.downcase
    res = []
    # TODO: use min/max length for loop index instead of looping
    # all and then use if test to decide if to add or not
    0.upto(value.length - 1) do |index|
      index.upto(value.length - 1) do |len|
        if value[index..len].length >= min_length && value[index..len].length <= max_length
            res << value[index..len] 
        end
      end
    end
    res  
  end
  
  
  # Ask Babel about the language of this text
  # Can return nil if no language found
  def language(options = {})
    Babel.guess(self, options)
  end
  
  # Tell Babel that this text is in a given language
  def language=(lang, options = {})
    Babel.learn(lang, self, options)
  end
end
