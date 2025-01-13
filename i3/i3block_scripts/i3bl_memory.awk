#!/usr/bin/env -S awk -f
/^MemTotal:/ {total=$2}
/^(MemFree|Buffers|Cached):/ {free+=$2}
END {
    total_G = total / 1024^2
    used_G = (total-free) / 1024^2
    percent = 100 / total_G * used_G

    printf "🧠 %.1fG/%.1fG (%.0f%%)\n", used_G, total_G, percent
    printf "%.0f%%\n", percent
    if (percent > 85) printf "#FF2015\n"
    else if (percent > 70) printf "#FFE061\n"
    else printf "#B7D076\n"
}

