#!/usr/bin/zsh
# the above is the schbang, tells which shell interpreter to use
ps -A | grep xremap
match_found=$?

# if the process does not exist, we only then run it again
if [ $match_found -ne 0 ]; then
  xremap ~/.config/xremap/config.yml > /dev/null 2>&1 & 
  # this is so damn interesting, let me explain why this works
  # now xremap when loading the config, goes into watch mode so it gives a looped stdout (basically stuck in the process)
  # a normal & to run it parallely (unsure but I think it must be only partly running the process in parallel), so as a work around
  # we send, the stdout to /dev/null it's like a blackhole and we also convert the stderr stream to stdout this is super cool cause,
  # 1. I didn't know, that stdout and stderr are two different streams (this makes mad sense)
  # 2. /dev/null
  # 3. Even, after running something parallely if it's in watch mode the stdout stream would 
  # still be referencing the older terminal window (I think there's a gap here but uncertain)
fi
