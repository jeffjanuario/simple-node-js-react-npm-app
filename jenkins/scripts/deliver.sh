#!/usr/bin/env sh
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

host(){
    if [ $HOSTNAME != 'c77f10f525dc' ] 
        then 
            echo $HOSTNAME
        else 
            echo "ubnserver"
    fi
}   

echo 'The following "npm" command builds your Node.js/React application for'
echo 'production in the local "build" directory (i.e. within the'
echo '"/var/jenkins_home/workspace/simple-node-js-react-app" directory),'
echo 'correctly bundles React in production mode and optimizes the build for'
echo 'the best performance.'
set -x
npm run build
set +x

echo 'The following "npm" command runs your Node.js/React application in'
echo 'development mode and makes the application available for web browsing.'
echo 'The "npm start" command has a trailing ampersand so that the command runs'
echo 'as a background process (i.e. asynchronously). Otherwise, this command'
echo 'can pause running builds of CI/CD applications indefinitely. "npm start"'
echo 'is followed by another command that retrieves the process ID (PID) value'
echo 'of the previously run process (i.e. "npm start") and writes this value to'
echo 'the file ".pidfile".'
set -x
npm start &
sleep 1
echo $! > .pidfile
set +x

echo 'Now...' 
echo 'Visit http://'$(host)':3000 to see your Node.js/React application in action.'
echo '(This is why you specified the "args ''-p 3000:3000''" parameter when you'
echo 'created your initial Pipeline as a Jenkinsfile.)'

echo '#HOSTNAME: http://'$(host)':3000'>> output.txt
echo '#DATA DA EXECUÇÃO: '$(date +"%d-%m-%y")>> output.txt


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

