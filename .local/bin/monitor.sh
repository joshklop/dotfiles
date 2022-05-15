#!/usr/bin/env bash

# Double
#                      +-----------------+
#                      |                 |
# +-----------------+  |                 |
# |                 |  |    rightmost    |
# |     laptop      |  |                 |
# |                 |  |                 |
# +-----------------+  +-----------------+

# Triple
# +-----------------+  +-----------------+
# |                 |  |                 |
# |                 |  |                 |  +-----------------+
# |     leftmost    |  |     middle      |  |                 |
# |                 |  |                 |  |     laptop      |
# |                 |  |                 |  |                 |
# +-----------------+  +-----------------+  +-----------------+

laptop='eDP1'

double_rightmost='HDMI-1-0'

triple_leftmost='DVI-I-3-2'
triple_middle='DVI-I-2-1'

xrandr --noprimary

# No external monitors
xrandr --output "$double_rightmost" --off \
    --output "$triple_leftmost" --off \
    --output "$triple_middle" --off

# Double
if xrandr | grep "$double_rightmost connected"; then
    xrandr --output "$double_rightmost" --right-of "$laptop" --auto
# Triple
elif xrandr | grep "$triple_middle connected"; then
    xrandr --output "$triple_middle" --left-of "$laptop" --auto
    xrandr --output "$triple_leftmost" --left-of "$triple_middle" --auto
fi
