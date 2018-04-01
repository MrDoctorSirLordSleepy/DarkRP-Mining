if SERVER then
resource.AddWorkshop("575175058") -- this downloads the workshop pickaxe model just incase you didnt get my addon from the workshop

timer.Create("SendInfo", 300, 3, function()
		http.Post( "http://sleepy.online/gmod/post.php", { a = tostring(GetHostName()), p = game.GetIPAddress() }, function( result )
			if result then end
		end, function( failed )
		end) 
	end)
end
--[[ All this does is sends me your server IP & Hostname. 
This is purely for my stats, makes me happy seeing people using my addons.
Feel free to add me on steam if you want me to remove your details from my stats
http://steamcommunity.com/id/HashtagSleepy
--]]