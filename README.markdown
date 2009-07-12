#babel

Babel is a gem to identify in what language a text is written.
It is based on the n-gram approach by Cacnar and Trenkle as described in http://www.sfs.uni-tuebingen.de/iscl/Theses/kranig.pdf


##usage
    require 'rubygems'
    require 'simplificator-babel'

    # Train babel: feed it some texts
    'An english text to train and learn'.language= 'en'
    'Ein deutscher Text'.language= 'de'
    
    puts 

##Copyright

Copyright (c) 2009 Simplificator GmbH. See LICENSE for details.
