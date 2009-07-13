#
# 
# Profile Generation:
# Whenever it's about generating a Profile (Babel.learn, Babel.distances and Babel.guess)
# you can pass 
#  * :min_length (2)
#  * :max_length (5)
#  * :pad (true)
# They are just forwared to String.n_grams (default values in braces)
# It's highly recomended that you use the same settings for learning and guessing....



module Babel
  @profiles = {}
  PROFILE_DIR = File.join(File.dirname(__FILE__), '..', 'profiles')
  
  # Learn that a text is in a given language.
  # Calls Profile.learn for the profile with the given language.
  def self.learn(lang, text, options = {})
    lang = lang.to_s
    profile = @profiles[lang] ||= Profile.new(lang)
    profile.learn(text, options)
  end

  # Clear all the profiles
  def self.clear_profiles
    @profiles = {}
  end
  # find the profile for a language
  def self.profile(lang)
    @profiles[lang]
  end
  
  # register a profile
  # pass :merge => true to merge into an existing profile
  def self.register_profile(profile, options = {})
    if options[:merge] && @profiles[profile.language]
      @profiles[profile.language].merge(profile)
    else
      @profiles[profile.language] = profile
    end
  end
  
  # Guess the language of a text.
  # As soon as there is at least one profile, this method always
  # returns a value (perhaps the wrong) one... 
  # I.e. if only "eng" profile is registered, then this method will always retun "eng"
  # not matter what text pass
  #
  def self.guess(source, options = {})
    distances = Babel.distances(source, options)
    distances.first.first if distances.first
  end
  
  # An array of arrays of [language, distance] arrays.
  # The language with the shortest distance is the most probable solution.
  # Sorted by distance, ascending (first item is most probable)
  def self.distances(text, options = {})
    source = Profile.new.learn(text, options)
    @profiles.map { |lang, target| [lang, source.distance(target)] }.sort {|o1, o2| o1.last <=> o2.last}
  end
  

  # Load all the profiles from a given directory.
  # Loads all .yml files so be careful what directory you specify.
  # options are:
  #  * :dir the directory, defaults to Babel::PROFILE_DIR
  # See Babel.load_profile() for other options
  def self.load_profiles(options = {})
    dir = options[:directory] || PROFILE_DIR
    Dir[File.join(PROFILE_DIR, '*.yml')].each do |file|
      Babel.load_profile(file, options)
    end
  end
  
  # Load a single profile
  # Options are:
  #  * :merge see Babel.register_profile for details
  def self.load_profile(file, options = {})
    Babel.register_profile(YAML.load_file(file), options)
  end
  
  # Save the profiles to a specifified directory.
  # See Babel.save_profile() for options
  def self.save_profiles(options = {})
    @profiles.each do |lang, profile|
      Babel.save_profile(lang, options)
    end
  end
  
  # Save a specific profile
  # Options are:
  # * :dir -> the directory wo save the files to. Defaults to Babel::PROFILE_DIR
  # * :limit -> Call limit() on the profile before save. This reduces the size of the profile 
  #             for the cost of (possibly) less accurate language guessing
  def self.save_profile(lang, options = {})
    dir = options[:dir] || PROFILE_DIR
    profile = Babel.profile(lang)
    profile.limit(options[:limit]) if options[:limit]
    File.open(file_name(dir, lang), 'wb') do |file|
      file.write(profile.ya2yaml)
    end
  end  

  private
  
  # Build the file name for a profile file
  # Naming scheme: profile_<LANG>.yml
  def self.file_name(dir, lang)
    File.join(dir, "profile_#{lang}.yml")
  end
  
end

