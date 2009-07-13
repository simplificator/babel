#babel

Babel is a gem to identify in what language a text is written.
It is based on the n-gram approach by Cavnar and Trenkle as described 
in http://www.sfs.uni-tuebingen.de/iscl/Theses/kranig.pdf


##usage
    require 'rubygems'
    require 'babel'
    
    def guess_language(s)
      puts "'#{s}' is probably '#{s.language}'"
    end
    # load the default profiles
    Babel.load_profiles
    
    # Let's see what Babel thinks about these texts
    guess_language 'Montags ist es ruhig'
    guess_language 'le coq est mort'
    
    # Replace a profile with my own profile
    Babel.load_profile('eng', '/path/to/my/english/profile.yml')
    
    # Merge profile data
    Babel.load_profile('eng', '/path/to/my/other/english/profile.yml', :merge => true)
    
    # Show Top-3 Languages for a sentence
    puts "What language could this be written in?".languages[0..2]

##profiles
Profiles are collections of n-grams and the number of occurence of each ngram.
Babel uses n-grams with length 2-5 (bigram, trigram, tetragram, pentagram).
You can create your own profile and decide what n-grams to use and whether 
you want to limit or not if you want to.

These profiles are shipped with the gem: 
 * german (deu) (this profile is built from udhr_deu_1996.txt)
 * english (eng)
 * french (fra)
 * spanish (spa)
 * italian (ita)
 
Want another profile built in? Send an email to info@simplificator.com and if there are enough 
requests we add the profile.

The profiles that are shipped with babel are based on the texts found at
http://www.unicode.org/udhr/index_by_code.html

##generating profiles
Profiles can be generated with the data found in http://www.unicode.org/udhr/assemblies/udhr_txt.zip or with any other text.
Once a profile is generated, Babel can store it in YAML format and load it again from YAML.

there is a rake task which simplifies profile generation:
   rake babel:build_profile lang=foo file=myfile.txt dir=destination-directory

the file which is generated from this command can be loaded by 
   Babel.load_profile 'foo', 'profile_foo.yml'

##Copyright

Copyright (c) 2009 Simplificator GmbH. See LICENSE for details.
