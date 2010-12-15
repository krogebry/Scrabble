#!/usr/bin/ruby
##
# Load some data into the db.
##
require 'init.rb'

begin

	cWords = DBConn.collection( "words" )

	File.open( "../data/fulldictionary00.txt" ).read.each do |l|
		#word = l.chop()

		cWords.save({ :word => l.chop() })
	end

rescue => e
	puts "Caught exception: #{$!}"
	puts e.backtrace()

end

