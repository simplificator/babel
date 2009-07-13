module Babel
  @profiles = {}
  # The default directory for profiles
  PROFILE_DIR = File.join(File.dirname(__FILE__), '..', 'profiles')
  
  # Learn that a text is in a given language.
  # Calls Profile.learn for the profile with the given language.
  #
  # See String.n_grams for description (lib/babel/string_extensions.rb) of options and Profile.learn
  # for default values used by Babel.
  def self.learn(lang, text, options = {})
    lang = lang.to_s
    profile = @profiles[lang] ||= Profile.new()
    profile.learn(text, options)
  end

  # Clear all the profiles
  def self.clear_profiles
    @profiles = {}
  end
  
  # Guess the language of a text.
  # As soon as there is at least one profile, this method always
  # returns a value (perhaps the wrong) one... 
  # I.e. if only "eng" profile is registered, then this method will always retun "eng"
  # not matter what text pass
  #
  # See String.n_grams for description (lib/babel/string_extensions.rb) of options and Profile.learn
  # for default values used by Babel.
  def self.guess(source, options = {})
    found = nil
    Babel.distances(source, options).each do |entry|
      found = entry if found.nil? || entry.last < found.last
    end
    found.first if found
  end
  
  # An array of arrays of [language, distance] arrays.
  # The language with the shortest distance is the most probably solution.
  #
  # See String.n_grams for description (lib/babel/string_extensions.rb) of options and Profile.learn
  # for default values used by Babel.
  def self.distances(text, options = {})
    source = Profile.new.learn(text, options)
    @profiles.map { |lang, target| [lang, source.distance(target)] }
  end
  

  # Load all the profiles from a given directory.
  # Loads all .yml files so be careful what directory you specify.
  # If the content or the file name scheme does not match Babels expectations 
  # it will fail.
  #
  # options are:
  #  * :dir the directory, defaults to Babel::PROFILE_DIR
  def self.load_profiles(options = {})
    dir = options[:directory] || PROFILE_DIR
    Dir[File.join(PROFILE_DIR, '*.yml')].each do |file|
      file =~ /profile_(.+)\.yml/
      @profiles[$1] = YAML.load_file(file)
    end
  end
  
  # Save the profiles to a specifified directory.
  #
  # options are:
  #  * :dir the directory, defaults to Babel::PROFILE_DIR
  #  * :limit if specified, then the profile is limited to that many entries before it is saved 
  def self.save_profiles(options = {})
    dir = options[:directory] || PROFILE_DIR
    @profiles.each do |lang, profile|
      profile.limit(options[:limit]) if options.has_key?(:limit)
      File.open(file_name(dir, lang), 'wb') do |file|
        file.write(profile.ya2yaml)
      end
    end
  end
  
  private
  
  # Build the file name for a profile file
  # Naming scheme: profile_<LANG>.yml
  def self.file_name(dir, lang)
    File.join(dir, "profile_#{lang}.yml")
  end
  
end

