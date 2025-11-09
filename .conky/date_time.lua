function conky_getweekday()
    return os.date("%A")           -- Sunday
end

function conky_getdate()
    return os.date("%d %B %Y")     -- 12 DECEMBER 2021
end

function conky_gettime()
    return os.date("%H:%M")        -- 13:20 (24-hour, no AM/PM)
end
