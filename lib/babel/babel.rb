require 'yaml'
module Babel
  @profiles = {}
  GUESS_DISTANCE_TRESHOLD = 60
  
  MAX_DISTANCE_PER_NGRAM = 3
  DEFAULT_FILE_NAME = 'babel_profile.yml'
  
  PROFILE_DIR = File.join(File.dirname(__FILE__), '..', 'profiles')
  
  # "learn". build profile and memorize
  def self.learn(lang, text, options = {})
    lang = lang.to_s
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
    source.each do |key, value|
      distance += [((target[key] || 0) - value).abs, MAX_DISTANCE_PER_NGRAM].min
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
  
  # Load a specific profile ()
  def self.load_profile(lang = nil)
    if lang.nil?
      Dir[File.join(PROFILE_DIR, '*.yml')].each do |file|
        lang =File.basename(file)[-6..-5]
        @profiles[lang] = YAML.load_file(file)
      end
    else  
      lang = lang.to_s
      @profiles[lang] = YAML.load_file(file_name(lang))
    end
    
  end
  
  def self.save_profile(lang = nil)
    if lang.nil?
      @profiles.each do |lang, profile|
        File.open(file_name(lang), 'wb') do |file|
          YAML.dump(profile, file)
        end
      end
    else
      lang = lang.to_s
      File.open(file_name(lang), 'wb') do |file|
        YAML.dump(@profiles[lang], file)
      end
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
  
  
  def self.file_name(lang)
    File.join(PROFILE_DIR, "profile_#{lang}.yml")
  end
end

