require 'irb/ext/save-history'

#History configuration
IRB.conf[:SAVE_HISTORY] = 1000

require "awesome_print"
AwesomePrint.irb! index: false

