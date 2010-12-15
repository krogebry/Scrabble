##
# Init for bin scripts
##
require 'rubygems'
require 'net/http'
require 'time'
require 'mongo'
require 'mongo_mapper'
include Mongo
require 'memcache'
require 'rexml/document'
include REXML

require '../config/config.rb'

MongoMapper.connection  = Connection.new( DBHostname,DBPort )
MongoMapper.database    = DBName

DBConn      = Connection.new( DBHostname,DBPort ).db( DBName )

#require "../models/Product.rb"
Dir.glob(File.join("../libs/**", '*.rb')).sort().each { |f| require f }
Dir.glob(File.join("../models/**", '*.rb')).sort().each { |f| require f }

MCache	= MemCache.new( MCServers )
SStr	= SecureStrings.new()

Log = Logger.new(STDOUT)
Log.formatter   = Logger::Formatter.new()
Log.level = Logger::DEBUG

