#!/usr/bin/ruby
##
# Load some data into the db.
##
require 'init.rb'

begin
	vowels = [ :a, :e, :i, :o, :u ]

	vals = {
		:a	=> 1,
		:b	=> 1,
		:c	=> 4,
		:d	=> 2,
		:e	=> 1,
		:f	=> 4,
		:g	=> 3,
		:h	=> 4,
		:i	=> 1,
		:j	=> 10,
		:k	=> 5,
		:l	=> 1,
		:m	=> 1,
		:n	=> 1,
		:o	=> 1,
		:p	=> 4,
		:q	=> 10,
		:r	=> 1,
		:s	=> 1,
		:t	=> 1,
		:u	=> 2,
		:v	=> 10,
		:w	=> 4,
		:x	=> 10,
		:y	=> 4,
		:z	=> 10
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

