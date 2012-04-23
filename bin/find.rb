#!/usr/local/bin/ruby
##
# Load some data into the db.
##
require "./init.rb"
require "optparse"

options = { :verbose => true }
optParse    = OptionParser.new do |opts|
	opts.banner = "Usage: finder.rb [--verbose]"

    opts.on("-v", "--verbose", "Run verbosely") do |v|
        options[:verbose] = v
    end

	opts.on("-l", "--letters LETTERS", "Letters") do |letters|
		options[:letters] = letters
	end

	opts.on("-r", "--range RANGE", "Range configuration") do |range|
		options[:range] = range
	end

	opts.on_tail("-h", "--help", "Show this message") do
		puts opts
		exit
	end
end
optParse.parse( ARGV )

begin
	cWords = DBConn.collection( "words" )

	#File.open( "../data/fulldictionary00.txt" ).read.each do |l|
		#word = l.chop()
		#cWords.save({ :word => l.chop() })
	#end

	strWordGroup = %{a,n,f,e,b,k}
	#strWordGroup = options[:letters]

	#spaces = [1,3,1,1,1,1]
	#spaces = [1,1,1,1,3,1]
	#spaces = [1,1,1,1,3]
	spaces = [1,1,1,1,1,1]

	#re = /^[#{strWordGroup}]{1}e[#{strWordGroup}]{1,2}$/
	re = /^c[#{strWordGroup}]{4}$/

	if(false)
	reGroup = []
	tileCnt = 0
	reStr = ""
	#range = options[:range]
	options[:range].split( "," ).each do |tile|
		#Log.debug( "Tile" ){ (tile.to_i > 0) }
		if(tile.length == 1 && tile.to_i() > 0)
			Log.warn( "Tile value" ){ tile.to_i }
			tileCnt += 1
		elsif(tile.length == 1)
			Log.warn( "Search letter" ){ tile }
		elsif(tile.length > 1)
			Log.warn( "Word multiplier" ){ tile }
		end
	end
	exit
	end

	Log.info( "Re" ){ re }

	potentials = cWords.find({ :word => re }).sort([[ "val",1 ]])

	Log.debug( "Num potentials" ){ potentials.count() }

	wordGroupLetterCount = {}
	strWordGroup.each_char do |letter|
		wordGroupLetterCount[letter] = 0 if(wordGroupLetterCount[letter] == nil)
		wordGroupLetterCount[letter] += 1
	end

	#Log.debug( "WordGroup" ){ wordGroupLetterCount.inspect }

	words = []
	potentialWords = []

	## prune out any words that contain more letters then we have in the pattern
	potentials.each do |word|
		letterCount = {}
		Log.warn( "Word" ){ word }
		word["word"].each_char do |letter|
			Log.debug( "Letter" ){ letter }
			next if(word == nil)
			letterCount[letter] = 0 if(letterCount[letter] == nil)
			letterCount[letter] += 1
			#Log.debug( "WordGroup" ){ wordGroupLetterCount[letter] }
			#Log.debug( "LetterCount %s" % letter ){ (letterCount[letter] > wordGroupLetterCount[letter] ? true : false ) }
			next if(wordGroupLetterCount[letter] == nil)
			if(letterCount[letter] > wordGroupLetterCount[letter])
				word = nil
				next
			end
		end
		potentialWords.push( word["word"] ) if(word != nil)
	end

	Log.debug( "Potentials after letter scrape" ){ potentialWords.count }

	potentialWords.each do |word|
		pVal = 0
		i = (spaces.size - word.size)
		#Log.warn( "Word" ){ "%i %s" % [word["val"].to_i(),word["word"]] }
		#Log.warn( "Ey" ){ i }
		word.each_char do |letter|
			pVal += (LetterValues[letter.to_sym()] * spaces[i])
			i+=1
		end
		#word[:pVal] = pVal
		#next if(word["word"].size != 5)
		#Log.warn( "Word" ){ "%i %s" % [pVal,word["word"]] }
		words.push({ :pVal => pVal, :word => word })
	end

	words.sort(){|a,b| a[:pVal] <=> b[:pVal] }.each do |word|
		Log.warn( "Word" ){ "%i %s" % [word[:pVal],word[:word]] }
	end

rescue => e
	puts "Caught exception: #{$!}"
	puts e.backtrace()

end

