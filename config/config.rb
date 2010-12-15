##
# Configuration file for main application
##
ApplicationName	= "framework"

## Database settings
DBName  	= "framework"
DBPort  	= 10000
DBHostname	= "devel01"
#DBHostname	= "localhost"

RTMPHost	= "192.168.1.89"

URLMediaShare	= "http://framework.devel.ksonsoftware.com/ms"

FSProdAppLogFile	= "/var/log/thin/framework.app.log"
FSProdErrorLogFile	= "/var/log/thin/framework.error.log"

FSFilesContainer	= "/usr/local/data/framework/files"
FSVideosContainer	= "/usr/local/data/framework/videos"

FSDocRoot	= "/var/www/ksonsoftware.com/dev/framework"

MCServers   = ["devel01:11211"]
