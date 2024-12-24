function wesnoth.wml_actions.fade_out_music(cfg)
    local duration = cfg.duration

    if duration == nil then
        duration = 1000
    end

    duration = duration - 10

    local delay_granularity = 10

    duration = math.max(delay_granularity, duration)
    local rem = duration % delay_granularity

    if rem ~= 0 then
        duration = duration - rem
    end

    local steps = duration / delay_granularity

    for k = 1, steps do
        local v = mathx.round(100 - (100*k / steps))
        wesnoth.music_list.volume = v
        wesnoth.delay(delay_granularity)
    end

    wesnoth.music_list.clear()

    if wesnoth.music_list.current then
        wesnoth.music_list.current.ms_after = 0
    end

    wesnoth.music_list.add("silence.ogg", true)

    wesnoth.delay(10)

    wesnoth.music_list.volume = 100.0
end

local function wml_sfx_volume_fade_internal(duration, is_fade_out)
    if duration == nil then
        duration = 1000
    end

    local delay_granularity = 10

    duration = math.max(delay_granularity, duration)
    duration = duration - (duration % delay_granularity)

    local steps = duration / delay_granularity

    for k = 1, steps do
        local v = 0

        if is_fade_out then
            v = mathx.round(100 - (100*k / steps))
        else
            v = mathx.round(100*k / steps)
        end

        wesnoth.sound_volume(v)

        wesnoth.delay(delay_granularity)
    end
end
