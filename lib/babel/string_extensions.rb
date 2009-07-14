class String 
  # Generate n-grams for a string.
  # options are:
  #  :min_length : minimum length of the n-grams (defaults to 1)
  #  :max_length : maximum length of the n-grams (defaults to self.length)
  #  :pad : pad wiht '_' to generate all possible n-grams (defaults to false)
  def n_grams(options = {})
    # TODO: recursive?
    # TODO: use min/max length for loop index instead of looping
    # all and then use if test to decide if to add or not
    min_length = options[:min_length] || 1
    max_length = options[:max_length] || self.length
    pad = options[:pad] || false
    value = options[:preserve_case] ? self : self.downcase
    value = "_#{value}#{'_' * (value.length - 1)}" if pad
    res = []
    0.upto(value.length - 1) do |index|
      index.upto(value.length - 1) do |len|
        if value[index..len].length >= min_length && value[index..len].length <= max_length
          ngram = value[index..len]
          res << ngram unless ngram.count('_') == ngram.size 
        end
      end
    end
    res  
  end
  
  # Ask Babel about the language of this text.
  # Convenience method, just calls Babel.guess().
  # See Babel.guess for description.
  def language(options = {})
    Babel.guess(self, options)
  end
  # Ask Bable about the languages this text could be.
  # It will return all the registered languages with the most probable
  # Language first. You might want to restrict this before presenting to 
  # the user.
  def languages(options = {})
    Babel.distances(self, options).map() {|item| item.first}
  end
  
  # Tell Babel that this text is in a given language.
  # Convenience method, just calls Babel.learn().
  # See Babel.learn for description
  def language=(lang, options = {})
    Babel.learn(lang, self, options)
  end
end
