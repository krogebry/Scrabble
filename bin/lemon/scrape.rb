#!/usr/bin/ruby
require "rubygems"
require "pp"
require "json"
require "nokogiri"
require "net/https"

@headers = { "cookie" => "" }

uri = URI( "https://dashboard.lemon.com" )
http = Net::HTTP.new( uri.host,uri.port )
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

if( true )
	get_session = Net::HTTP::Get.new( "/login/" )
	res = http.request( get_session )

	#puts "Res: %i" % res.code
	#puts "Location: %s" % res["location"]
	#puts "Cookie: %s" % res["Set-Cookie"]
	#res.each do |k,v| puts "%s: %s" % [k,v] end

	@headers["cookie"] = res["Set-Cookie"]

	f = File.open( "/tmp/lemon.com","w" )
	f.puts( res.body )
	f.close
end

doc = Nokogiri::HTML(open( "/tmp/lemon.com" ))
auth_value = doc.xpath( "//input[@name='auth']" )[0].attributes["value"].value
#puts "AuthValue: %s" % auth_value

if( true )
	login = Net::HTTP::Post.new( "/login/" )

	login.set_form_data({ 
		:auth => auth_value,
		:remember => "on",
		:username => "bryan.kroger@lemon.com", 
		:password => "orange1" 
	})

	login["Cookie"] = @headers["cookie"]
	login["Content-Type"] = "application/x-www-form-urlencoded"

	res = http.request( login )

	#res.each do |k,v| puts "%s: %s" % [k,v] end
	#puts "Code: %i" % res.code

	#@headers["cookie"] = res["Set-Cookie"]
	#puts "Cookie: %s" % res["Set-Cookie"]

	f = File.open( "/tmp/dashboard.lemon.com","w" )
	f.puts( res.body )
	f.close
end

if( true )
	(1..Time.new.mon.to_i()).each do |i|
		r = Net::HTTP::Post.new( "/purchases/process.php" )
		r.set_form_data({ 
			:sort => "date",
			:month => "2012-%i-01" % i,
			:action => "getReceipts",
			:category => 11,
			:categoryType => "main"
		})
		r["Cookie"] = @headers["cookie"]
		r["X-Requested-With"] = "XMLHttpRequest"
		res = http.request( r )
		#@headers["cookie"] = res["set-cookie"]
		f = File.open( "/tmp/process.lemon.com","w" )
		f.puts( res.body )
		f.close

		json = JSON::parse(open( "/tmp/process.lemon.com" ).read)
		#pp json["purchases"]

		if( true )
			json["purchases"].each do |p|
				p_file = "data/%i.json" % p["id"]
				if(!File.exists?( p_file ))
					puts "Getting: %i" % p["id"]
					r = Net::HTTP::Post.new( "/common/processPurchase.php" )
					r.set_form_data({ 
						:id => p["id"].to_i(),
						:action => "getReceiptDetail"
					})
					r["Cookie"] = @headers["cookie"]
					r["X-Requested-With"] = "XMLHttpRequest"
					res = http.request( r )
					#@headers["cookie"] = res["set-cookie"]
					f = File.open( p_file,"w" )
					f.puts( res.body )
					f.close
	
					sleep rand( 5 )
				end ## File.exists?
			end ## purchases
		end ## true/false
	end ## [1..MonthNum].each

end ## true/false

#json = JSON::parse(open( "/tmp/purchase.1.lemon.com" ).read)
#pp json["ticket"]["items"]


