module Babel
  MAX_DISTANCE_PER_NGRAM = 3

  @profiles = {}
  
  DEFAULT_FILE_NAME = 'babel_profile.yml'
  
  PROFILE_DIR = File.join(File.dirname(__FILE__), '..', 'profiles')
  
  # "learn". build profile and memorize
  def self.learn(lang, text, options = {})
    lang = lang.to_s
    options = {:min_length => 2, :max_length => 5}.merge(options)
    @profiles[lang.to_s] ||= {}
    existing = @profiles[lang.to_s]
    profile = Babel.build_profile(text, options)
    profile.each do |key, value|
      existing[key] ||= [0, nil]
      existing[key][0] = existing[key][0] + value[0]
    end
    Babel.rank(existing)
    existing
  end
  
  

  def self.rank(profile)
    profile.values.sort() {|o2, o1| o1.first <=> o2.first}.each_with_index do |item, index|
      item[1] = index + 1
    end
  end
  
  def self.distance(source, target) 
    distance = 0
    source.each do |key, value|
      target_value = target[key]
      if target_value
        distance += [(target_value.first - value.first).abs, MAX_DISTANCE_PER_NGRAM].min
      else
        distance += MAX_DISTANCE_PER_NGRAM
      end
    end 
    distance
  end
  
  
  def self.guess(source, options = {})
    found = nil
    Babel.distances(source).each do |entry|
      found = entry if found.nil? || entry.last < found.last
    end
    found.first if found# && found.last <= (options[:treshold] || GUESS_DISTANCE_TRESHOLD)
  end
  
  # An array of arrays of [language, distance] arrays
  def self.distances(source)
    source = Babel.build_profile(source)
    @profiles.map { |lang, target| [lang, Babel.distance(source, target)] }
  end

  
  # Build the profile of a piece of text
  def self.build_profile(text, options = {})
    return text if text.is_a?(Hash)
    #text = Babel.clean_text(text)
    profile = {}
    text.split(' ').each do |word|
      ngrams = word.ngrams(options)
      ngrams.each do |ngram|
        profile[ngram] ||= [0, nil]
        profile[ngram][0] = profile[ngram][0] + 1
      end
    end
    profile
  end
  
  
  def self.file_name(lang)
    File.join(PROFILE_DIR, "profile_#{lang}.yml")
  end
  
  # remove some punctuation
  def self.clean_text(text)
    text.gsub!('.', '')
    text.gsub!(';', '')
    text.gsub!(',', '')
    text.gsub!('\'', '')
    text.gsub!('"', '')
    text
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
end

