#!/usr/bin/env -S awk -f
/^MemTotal:/ {total=$2}
/^(MemFree|Buffers|Cached):/ {free+=$2}
END {
    total_G = total / 1024^2
    used_G = (total-free) / 1024^2
    percent = 100 / total_G * used_G
    red = 255 * (percent / 100)
    green = 255 * (100 - percent) / 100

    printf "🧠 %.1fG/%.1fG (%.0f%%)\n", used_G, total_G, percent
    printf "%.0f%%\n", percent
    printf "#%02x%02x11\n", red, green
}
