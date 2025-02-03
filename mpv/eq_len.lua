-- Automatically goes to next file after a certain duration

duration = mp.get_opt("dur")
if(duration ~= nil) then
    active = true
    timer = nil
    print(string.format("Autoplay delay: \x1b[96m%ss\x1b[m",duration))

    function set_timer()
        if(timer) then
            timer:kill()
        end
        timer = mp.add_periodic_timer(duration, (function() mp.command("playlist-next") end))
    end
    set_timer()

    function update_name()
        title = string.format(
            "%s (%ss) %s",
            not active and "[Paused] " or "",
            duration,
            mp.get_property("media-title")
        )
        mp.set_property("title", title)
    end

    function toggle_pause()
        reset_timer()
        if not active then -- if it IS paused
            print("\x1b[96mAutoplay resumed\x1b[m")
            timer:resume()
            mp.osd_message("Resumed")
        elseif active then -- if it IS active
            timer:stop()
            print("\x1b[95mAutoplay paused\x1b[m")
            mp.osd_message("Paused", 999999)
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

    mp.add_key_binding("g", toggle_pause)
    mp.register_event("file-loaded", reset_timer)
    mp.register_event("file-loaded", update_name)
end
