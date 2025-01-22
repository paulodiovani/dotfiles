local function throttle(callback, delay)
    local is_throttled = false
    local timer = vim.loop.new_timer()

    return function(...)
        if not is_throttled then
            local args = {...}
            callback(unpack(args))

            is_throttled = true
            timer:start(delay, 0, vim.schedule_wrap(function()
                is_throttled = false
                timer:stop()
            end))
        end
    end
end

return throttle
