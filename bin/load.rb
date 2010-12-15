#!/usr/bin/ruby
##
# Load some data into the db.
##
require 'pp'
require 'rubygems'
require 'mongo'
require 'mongomapper'
include Mongo
require '../config.rb'
require 'time'

MongoMapper.connection  = Connection.new( DBHostname,DBPort )
MongoMapper.database    = DBName

["../libs", "../models/**" ].each do |path|
	Dir.glob(File.join(path, '*.rb')).sort().each { |f| require f }
end

@dbConn		= Connection.new( DBHostname,DBPort ).db( DBName )
#@dbConn.collection_names.each do |name|
	#@dbConn.collection( name ).clear()
#end

begin

rescue => e
	puts "Caught exception: #{$!}"
	puts e.backtrace()

end

