##
# Init for bin scripts
##
require 'rubygems'
require 'net/http'
require 'time'
require 'mongo'
require 'logger'
#require 'mongo_mapper'
require 'dalli'
include Mongo
require 'dalli'
require 'nokogiri'

require '../config/config.rb'
require '../config/values.rb'

#MongoMapper.connection = Connection.new( DBHostname,DBPort,{ :slave_ok => true })
#MongoMapper.database = DBName

DBConn = Connection.new( DBHostname,DBPort,{ :slave_ok => true, :pool_size => 10 }).db( DBName )

Dir.glob(File.join("../libs/**", '*.rb')).sort().each { |f| require f }
Dir.glob(File.join("../models/**", '*.rb')).sort().each { |f| require f }

Memc = Dalli::Client.new( "127.0.0.1:11211" )
#SStr = SecureStrings.new()

Log = Logger.new(STDOUT)
Log.formatter   = Logger::Formatter.new()
Log.level = Logger::DEBUG

