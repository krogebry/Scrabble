##
# Configuration file for main application
##
ApplicationName	= "Scrabble"

## Database settings
DBName  	= "Scrabble"
DBPort  	= 27017
#DBHostname	= "devel01"
DBHostname	= "localhost"

RTMPHost	= "192.168.1.89"

URLMediaShare	= "http://Scrabble.devel.ksonsoftware.com/ms"

FSProdAppLogFile	= "/var/log/thin/Scrabble.app.log"
FSProdErrorLogFile	= "/var/log/thin/Scrabble.error.log"

FSFilesContainer	= "/usr/local/data/Scrabble/files"
FSVideosContainer	= "/usr/local/data/Scrabble/videos"

FSDocRoot	= "/var/www/ksonsoftware.com/dev/Scrabble"

MCServers   = ["devel01:11211"]
