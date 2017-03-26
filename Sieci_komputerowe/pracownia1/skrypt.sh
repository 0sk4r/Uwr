#!/bin/sh
xterm -title "App1" -hold -e "sudo ./traceroute 94.23.242.48" &
xterm -title "App2" -hold -e "sudo ./traceroute 94.23.242.48"

xterm -title "Ping" -hold -e "ping 94.23.242.48" &
xterm -title "traceroute" -hold -e "sudo ./traceroute 94.23.242.48"

xterm -title "wikipedia" -hold -e "sudo ./traceroute 94.23.242.48" &
xterm -title "google" -hold -e "sudo ./traceroute 46.134.210.35"

xterm -title "App1" -hold -e "sudo ./traceroute 94.23.242.48" &
xterm -title "App2" -hold -e "sudo traceroute -I 94.23.242.48"


