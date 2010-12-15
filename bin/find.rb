#!/usr/bin/ruby
##
# Load some data into the db.
##
require 'init.rb'

begin

	cWords = DBConn.collection( "words" )

	#File.open( "../data/fulldictionary00.txt" ).read.each do |l|
		#word = l.chop()
		#cWords.save({ :word => l.chop() })
	#end

	#words = ["w","c","h","e","e","n","u" ]
	#tiles = ["n","t","t","i","q","w","e"]
	tiles = ["w","c","e","n","r","a","h"]

	strWordGroup = tiles.join( "," )

	#re = /^[#{words.join(",")}]{1,2}g[a-z]$/
	re = /^[#{strWordGroup}]{5}k$/

	Log.info( "Re" ){ re }

	words = cWords.find({
		:word => re
		#:word => { "$size" => 3 }
	})

	Log.debug( "Num words" ){ words.count() }

	words.each do |word|
		#next if(word.size != 4)
		Log.warn( "Word" ){ word["word"] }
	end

rescue => e
	puts "Caught exception: #{$!}"
	puts e.backtrace()

end

