#!/usr/bin/ruby
require "rubygems"
require "pp"
require "json"
require "nokogiri"
require "net/https"

products = {}

Dir.glob( "data/*.json" ).each do |data_file|
	#puts data_file
	json = JSON::parse(open( data_file ).read)
	#pp json
	json["ticket"]["items"].each do |item|
		products[item["description"]] ||= 0
		products[item["description"]] += 1
	end
end

#pp products.sort{|a,b| a[1]<=>b[1] }
products.each do |k,v| puts [k,v].join( "," ) end

