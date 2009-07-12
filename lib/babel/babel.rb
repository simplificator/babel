require 'yaml'
module Babel
  @profiles = {}
  GUESS_DISTANCE_TRESHOLD = 35
  
  MAX_DISTANCE_PER_NGRAM = 3
  DEFAULT_FILE_NAME = 'babel_profile.yml'
  # "learn". build profile and memorize
  def self.learn(lang, text, options = {})
    options = {:min_length => 2, :max_length => 5}.merge(options)
    @profiles[lang.to_s] ||= Hash.new(0)
    existing = @profiles[lang.to_s]
    profile = Babel.build_profile(text, options)
    profile.each do |key, value|
      existing[key] += value
    end
    existing
  end
  
  

  
  
  def self.distance(source, target) 
    distance = 0
    target.each do |key, value|
      distance += (source[key] - value).abs.at_most(MAX_DISTANCE_PER_NGRAM)
    end 
    distance
  end
  
  
  def self.guess(source, options = {})
    found = nil
    Babel.distances(source).each do |entry|
      found = entry if found.nil? || entry.last < found.last
    end
    found.first if found && found.last <= (options[:treshold] || GUESS_DISTANCE_TRESHOLD)
  end
  
  # An array of arrays of [language, distance] arrays
  def self.distances(source)
    source = Babel.build_profile(source)
    @profiles.map { |lang, target| [lang, Babel.distance(source, target)] }
  end
  
  def self.load_profiles(name = DEFAULT_FILE_NAME)
    @profiles = YAML.load_file(file_name(name))
    puts "Loadong from #{__FILE__}"
  end
  
  def self.save_profiles(name = DEFAULT_FILE_NAME)
    File.open(file_name(name), 'wb') do |file|
      YAML.dump(@profiles, file)
    end
  end
  private
  # Build the profile of a piece of text
  def self.build_profile(text, options = {})
    return text if text.is_a?(Hash)
    profile = Hash.new(0)
    text.split(' ').each do |word|
      ngrams = word.ngrams(options)
      ngrams.each do |ngram|
        profile[ngram] += 1
      end
    end
    profile
  end
  
  
  def self.file_name(name)
    name == DEFAULT_FILE_NAME ? File.dirname(__FILE__) + "/../#{DEFAULT_FILE_NAME}" : name
  end
end

