#!/usr/bin/env -S awk -f
BEGIN {"nproc" | getline nb_cpu}
{
    gsub("/.*", "", $4)
    color=int(nb_cpu) <= int($4) ? "#FF0000" : "#B7D076"
    text=sprintf("%s %s/%s", $1, $4, nb_cpu)
    printf "⌛ %s\n", text
    printf "%s\n", text
    printf "%s\n", color
}
