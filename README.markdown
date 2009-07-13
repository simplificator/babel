#babel

Babel is a gem to identify in what language a text is written.
It is based on the n-gram approach by Cacnar and Trenkle as described 
in http://www.sfs.uni-tuebingen.de/iscl/Theses/kranig.pdf


##usage


##profiles
Profiles are collections of n-grams and the number of occurence of each ngram.
Babel uses n-grams with length 2-5 (bigram, trigram, tetragram, pentagram) and limits the profile 
to the top 300 n-grams with the built in profiles. You can create your own profile and decide 
what n-grams to use and whether you want to limit or not.

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
   Babel.load_profile 'profile_foo.yml'

##Copyright

Copyright (c) 2009 Simplificator GmbH. See LICENSE for details.
