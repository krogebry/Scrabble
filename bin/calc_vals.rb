#!/usr/bin/ruby
##
# Load some data into the db.
##
require 'init.rb'

begin
	vowels = [ :a, :e, :i, :o, :u ]

	vals = {
		:a	=> 1,
		:n	=> 1,
		:m	=> 3,
		:u	=> 2,
		:s	=> 1,
		:o	=> 1,
		:r	=> 1
	}

	cWords = DBConn.collection( "words" )

	#File.open( "../data/fulldictionary00.txt" ).read.each do |l|
		#word = l.chop()
		#cWords.save({ :word => l.chop() })
	#end

	cWords.find().each do |w|
		val = 0
		w["word"].each_char do |letter|
			#Log.warn( "Val" ){ vals[letter.to_sym()] }
			#Log.warn( "Letter" ){ letter }
			val += vals[letter.to_sym()].to_i()
		end
		w["val"] = val
		#cWords.update( w["_id"],w.join({ :val => val }) )
		cWords.update({ :_id => w["_id"] },w.merge({ :val => val }) )

		#Log.debug( "Word" ){ w.inspect }
	end

rescue => e
	puts "Caught exception: #{$!}"
	puts e.backtrace()

end

