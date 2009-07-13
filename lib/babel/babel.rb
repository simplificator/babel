module Babel
  MAX_DISTANCE_PER_NGRAM = 3

  @profiles = {}
  
  DEFAULT_FILE_NAME = 'babel_profile.yml'
  
  PROFILE_DIR = File.join(File.dirname(__FILE__), '..', 'profiles')
  
  def self.learn(lang, text, options = {})
    lang = lang.to_s
    profile = @profiles[lang] ||= Profile.new()
    profile.learn(text, options)
  end


  
  
  def self.guess(source, options = {})
    found = nil
    Babel.distances(source).each do |entry|
      found = entry if found.nil? || entry.last < found.last
    end
    found.first if found
  end
  
  # An array of arrays of [language, distance] arrays
  def self.distances(text)
    source = Profile.new.learn(text)
    @profiles.map { |lang, target| [lang, source.distance(target)] }
  end

  private
  
  def self.file_name(dir, lang)
    File.join(dir, "profile_#{lang}.yml")
  end
  
  # Load a specific profile ()
  def self.load_profiles(options = {})
    dir = options[:directory] || PROFILE_DIR
    Dir[File.join(PROFILE_DIR, '*.yml')].each do |file|
      lang =File.basename(file)[-6..-5]
      @profiles[lang] = YAML.load_file(file)
    end
  end
  
  def self.save_profiles(options = {})
    dir = options[:directory] || PROFILE_DIR
    @profiles.each do |lang, profile|
      profile.limit(options[:limit]) if options.has_key?(:limit)
      File.open(file_name(dir, lang), 'wb') do |file|
        file.write(profile.ya2yaml)
      end
    end
  end
end

