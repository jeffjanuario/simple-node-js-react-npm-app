#!/bin/bash
# https://www.shellscript.sh/tips/hms/
# Example of Hours, Minutes, Seconds.
# Look for the "*** To avoid having to wait" comments
#   for a quicker way of playing with this!

# Make a note of the start time (in seconds since 1970)
STARTTIME=`date +%s`
echo "`date`: Starting the script."

# Define hms() function
hms()
{
  # Convert Seconds to Hours, Minutes, Seconds
  # Optional second argument of "long" makes it display
  # the longer format, otherwise short format.
  local SECONDS H M S MM H_TAG M_TAG S_TAG
  SECONDS=${1:-0}
  let S=${SECONDS}%60
  let MM=${SECONDS}/60 # Total number of minutes
  let M=${MM}%60
  let H=${MM}/60
  
  if [ "$2" == "long" ]; then
    # Display "1 hour, 2 minutes and 3 seconds" format
    # Using the x_TAG variables makes this easier to translate; simply appending
    # "s" to the word is not easy to translate into other languages.
    [ "$H" -eq "1" ] && H_TAG="hour" || H_TAG="hours"
    [ "$M" -eq "1" ] && M_TAG="minute" || M_TAG="minutes"
    [ "$S" -eq "1" ] && S_TAG="second" || S_TAG="seconds"
    [ "$H" -gt "0" ] && printf "%d %s " $H "${H_TAG},"
    [ "$SECONDS" -ge "60" ] && printf "%d %s " $M "${M_TAG} and"
    printf "%d %s\n" $S "${S_TAG}"
  else
    # Display "01h02m03s" format
    [ "$H" -gt "0" ] && printf "%02d%s" $H "h"
    [ "$M" -gt "0" ] && printf "%02d%s" $M "m"
    printf "%02d%s\n" $S "s"
  fi
}



sh jenkins/scripts/deliver.sh




############################################################
# Main script - could be anything, but takes a
# non-predictable amount of time.
# Sleep for 8 hours (8h) unless some other value
# is passed to the script.
# *** To avoid having to wait, comment out the following line:
sleep ${1:-60}
############################################################

ps | grep 'node' | head -n 1 | awk '{print $1}' > .pidfile

sh jenkins/scripts/kill.sh

# At end of script, report how long it took.
# Make a note of the end time (in seconds since 1970)
echo "`date`: The script has finished."
ENDTIME=`date +%s`

# Calculate the difference - that's how long the script took to run
let DURATION=${ENDTIME}-${STARTTIME}
# *** To avoid having to wait, uncomment the following line:
#DURATION=$1

HOWLONG=`hms $DURATION`
echo "That took ${HOWLONG} to run (short format)"

HOWLONG=`hms $DURATION long`
echo "That took ${HOWLONG} to run (long format)"

