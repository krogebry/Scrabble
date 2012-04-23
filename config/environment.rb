##
# Scrabble, or whatever the heck this is!
#
# @author	Bryan Kroger ( bryan.kroger@gmail.com ) krogebry
# @author	Kira Kroger ( mistyayn@gmail.com )
require 'rubygems'
$KCODE = "UTF8"
require 'rack'
require 'time'
require 'jcode'
require 'bcrypt'
require 'ftools'
require 'erubis'
require 'logger'
require 'unicode'
require 'net/https'
require 'sinatra/base'
require '/var/lib/gems/1.8/gems/memcache-client-1.8.5/lib/memcache.rb'

require 'evernote'

require 'config/config.rb'
require 'libs/custom_logger'

begin
	Log = Logger.new( STDOUT )
	Log.formatter	= Logger::Formatter.new()
	Log.level = Logger::DEBUG
	#Log.fatal("Fatal")
	#Log.error("Error")
	#Log.warn("Warning")
	#Log.info("Info")
	#Log.debug("Debug")

	ENV['RACK_ENV'] ||= 'development'

	## Init the db connector for the mapped objects
	#MongoMapper.connection  = Connection.new( DBHostname,DBPort )
	#MongoMapper.database    = DBName

	#DBConn      = Connection.new( DBHostname,DBPort ).db( DBName )
	#Collection	= DBConn.collection( DBName )

	## Load helpers, modoles, libs, and mounts
	["helpers", "models", "models", "libs", "mounts", "mounts" ].each do |path|
		Dir.glob(File.join(path, '*.rb')).sort.each { |f| require f }
	end

	MCache		= MemCache.new({ :servers => MCServers })

rescue => e
	puts "Exception caught while trying to pre-cache elements: #{$!}"
	puts e.backtrace()
	exit

end

case ENV['RACK_ENV']
 when 'development'
	Log.debug( 'APPLICATION_STARTUP' ){ 'Starting in development mode..' }
 	APP_LOG 	= STDOUT
 	ACCESS_LOG 	= STDOUT

 when 'production'
	'Starting in production mode..'

  	APP_LOG 	= File.new( FSProdAppLogFile,"a" )
  	ACCESS_LOG 	= File.new( FSProdErrorLogFile,"a" )
  	STDOUT.reopen APP_LOG
  	STDERR.reopen APP_LOG
  
 else
  raise 'Configuration not found for this environment.'

end
