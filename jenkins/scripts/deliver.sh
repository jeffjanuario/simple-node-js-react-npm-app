#!/usr/bin/env sh 
echo 'The following "npm" command builds your Node.js/React application for'> output.txt
echo 'production in the local "build" directory (i.e. within the'>> output.txt
echo '"/var/jenkins_home/workspace/simple-node-js-react-app" directory),'>> output.txt
echo 'correctly bundles React in production mode and optimizes the build for'>> output.txt
echo 'the best performance.'>> output.txt
set -x  >> output.txt
npm run build >> output.txt
set +x >> output.txt

echo 'The following "npm" command runs your Node.js/React application in'>> output.txt
echo 'development mode and makes the application available for web browsing.'>> output.txt
echo 'The "npm start" command has a trailing ampersand so that the command runs'>> output.txt
echo 'as a background process (i.e. asynchronously). Otherwise, this command'>> output.txt
echo 'can pause running builds of CI/CD applications indefinitely. "npm start"'>> output.txt
echo 'is followed by another command that retrieves the process ID (PID) value'>> output.txt
echo 'of the previously run process (i.e. "npm start") and writes this value to'>> output.txt
echo 'the file ".pidfile".'>> output.txt
set -x >> output.txt
npm start & >> output.txt
sleep 1 >> output.txt
echo $! > .pidfile >> output.txt
set +x >> output.txt

echo 'Now...' >> output.txt
echo 'Visit http://'$HOSTNAME':3000 to see your Node.js/React application in action.'>> output.txt
echo '(This is why you specified the "args ''-p 3000:3000''" parameter when you'>> output.txt
echo 'created your initial Pipeline as a Jenkinsfile.)'>> output.txt

