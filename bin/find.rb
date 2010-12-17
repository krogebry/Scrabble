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

	strWordGroup = %{o,d,o,f,h,i,d}

	#spaces = [1,3,1,1,1,1]
	#spaces = [1,1,1,1,3,1]
	#spaces = [1,1,1,1,3]
	spaces = [1,1,1,1,1,1]

	#re = /^[#{strWordGroup}]{1}e[#{strWordGroup}]{1,2}$/
	re = /^j[#{strWordGroup}]{1,5}$/

	Log.info( "Re" ){ re }

	potentials = cWords.find({ :word => re }).sort([[ "val",1 ]])

	Log.debug( "Num potentials" ){ potentials.count() }

	## venue = 12 / 11

	words = []

	potentials.each do |word|
		pVal = 0
		i = (spaces.size - word["word"].size)
		#Log.warn( "Word" ){ "%i %s" % [word["val"].to_i(),word["word"]] }
		#Log.warn( "Ey" ){ i }
		word["word"].each_char do |letter|
			pVal += (LetterValues[letter.to_sym()] * spaces[i])
			i+=1
		end
		#word[:pVal] = pVal
		#next if(word["word"].size != 5)
		#Log.warn( "Word" ){ "%i %s" % [pVal,word["word"]] }
		words.push({ :pVal => pVal, :word => word["word"] })
	end

	words.sort(){|a,b| a[:pVal] <=> b[:pVal] }.each do |word|
		Log.warn( "Word" ){ "%i %s" % [word[:pVal],word[:word]] }
	end

rescue => e
	puts "Caught exception: #{$!}"
	puts e.backtrace()

end

