#!/bin/bash
sleep $(($1 * 60)) && notify-send "$2" &
