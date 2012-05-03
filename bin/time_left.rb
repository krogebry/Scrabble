#!/usr/local/bin/ruby

days = ((Time.new( 2013,03,26 ).to_i - Time.new.to_i)/86400)
months = (days/30)
puts "%i days\t%i months" % [days,months]
