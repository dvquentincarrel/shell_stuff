-- Automatically goes to next file after a certain duration

--[[
require 'os'
require 'io'
require 'string'
print("eq_len loaded")
print("dur = " .. mp.get_opt("dur"))
function tfunc2()
	os.execute("sleep " .. mp.get_opt("dur"))
	mp.command("playlist-next")
end
mp.register_event("file-loaded", tfunc2)
]]--

duration = mp.get_opt("dur")
if(duration ~= nil) then
	active = true

	function update_name()
		if active then
			mp.set_property("title", mp.get_property("media-title"))
		else
			mp.set_property("title", mp.get_property("media-title").." [Paused]")
		end
	end

	function pl_next()
		mp.command("playlist-next")
		update_name()
	end

	function toggle_state()
		if not active then -- if it IS paused
			print("autoplay resumed")
			timer:resume()
			mp.osd_message("Resumed")
		elseif active then -- if it IS active
			timer:stop()
			print("autoplay paused")
			mp.osd_message("Paused")
		end
        active = not active
		update_name()
	end

	function reset_timer()
		timer:kill()
		if (active) then
			timer:resume()
		end	
	end

	print("autplay delay: ",duration)
	timer = mp.add_periodic_timer(duration, pl_next)

	mp.add_key_binding("g", toggle_state)
	mp.register_event("file-loaded", reset_timer)
	mp.register_event("file-loaded", update_name)
end

