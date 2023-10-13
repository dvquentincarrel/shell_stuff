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
	state = 1

	function update_name()
		if(state == 1)
		then
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
		if (state == -1) then -- if it IS paused
			print("resumed")
			timer:resume()
			mp.osd_message("Resumed")
		elseif (state == 1) then -- if it IS active
			timer:stop()
			print("paused")
			mp.osd_message("Paused")
		end
		state = -1 * state
		update_name()
	end

	function reset_timer()
		timer:kill()
		if (state == 1) then
			timer:resume()
		end	
	end

	print("duration: ",duration)
	timer = mp.add_periodic_timer(duration, pl_next)

	mp.add_key_binding("g", toggle_state)
	mp.register_event("file-loaded", reset_timer)
	mp.register_event("file-loaded", update_name)
else
	print("Inactive")
end

