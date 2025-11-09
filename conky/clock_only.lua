conky.config = {
    background = false,
    update_interval = 1,
    double_buffer = true,
    no_buffers = true,

    own_window = true,
    own_window_type = 'desktop',
    own_window_transparent = true,
    own_window_argb_visual = true,
    own_window_argb_value = 0,
    own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',

    alignment = 'top_middle',
    gap_x = 0,
    gap_y = 60,

    use_xft = true,
    xftalpha = 1,
    default_color = 'white',
    uppercase = false,

    lua_load = '~/.conky/date_time.lua'
};

conky.text = [[
${voffset 10}${alignc}${font DejaVu Sans:style=Regular:size=130}${lua conky_gettime}${font}

${voffset -140}${alignc}${color #6A1B9A}${font Dancing Script:style=Bold:size=60}${lua conky_getweekday}${font}${color}

${voffset 18}${alignc}${font FreeMono:style=Bold:size=24}${lua conky_getdate}${font}
]];
