#!/usr/bin/ruby
##
# Load some data into the db.
##
require 'init.rb'

begin
	cWords = DBConn.collection( "words" )
	cWords.remove()
	File.open( "../data/twl06.txt" ).read.each do |l|
		cWords.save({ :word => l.chop().downcase() })
	end

rescue => e
	puts "Caught exception: #{$!}"
	puts e.backtrace()

end

