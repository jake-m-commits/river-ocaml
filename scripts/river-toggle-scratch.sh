#!/bin/sh

riverctl toggle-focused-tags $((1 << 20))
riverctl focus-view next
