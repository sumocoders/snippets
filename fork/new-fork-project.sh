#!/bin/bash

if [[ $# -ne 2 ]] ; then
  echo 'Usage: ./new-fork-project.sh <client> <project>'
  exit 1;
fi

client=$1
project=$2
repository="git@git.sumocoders.be:sumocoders/$project"

git ls-remote "$repository" &>-
if [ "$?" -ne 0 ]; then
  echo "Please create a repository named $project on Gitlab first!"
  exit 1;
fi

mkdir -p ~/Sites/$client/$project
cd ~/Sites/$client/$project
git clone git://github.com/sumocoders/forkcms.git .
rm -rf .git
git init
git add .
git commit -n -m 'initial commit'
git remote add origin $repository
git push --set-upstream origin master
git checkout -b staging
git push --set-upstream origin staging
echo -e "You will now be taken to Gitlab. Please set the default branch to 'staging'. Press return when you're done."
open http://git.sumocoders.be/sumocoders/$project/edit
read input_variable

sed -i '' -e 's/set :client.*/set :client, "'$client'"/g' Capfile
sed -i '' -e 's/set :project.*/set :project, "'$project'"/g' Capfile
sed -i '' -e 's|set :repository.*|set :repository, "'$repository'"|g' Capfile

sed -i '' -e 's|site.path_www:.*|site.path_www:          /home/sites/'$client'/'$project'|g' app/config/parameters_install.yml

git add .
git commit -n -m 'Add basic project info to be able to deploy'
git push

bundle install
cap sumodev:db:create
cap sumodev:db:get

composer install
npm install
grunt build

echo -e "The Fork installer will now be opened. The database settings will be printed below."
open http://$project.$client.dev/
database=$(cap sumodev:db:info 2>&1 | grep database -A 2 | tail -n 1 | sed -e 's/ \*\* \[out :: dev.sumocoders.be\] //g')
user=$(cap sumodev:db:info 2>&1 | grep user -A 3 | tail -n 1 | sed -e 's/ \*\* \[out :: dev.sumocoders.be\] //g')
pass=$(cap sumodev:db:info 2>&1 | grep pass -A 3 | tail -n 1 | sed -e 's/ \*\* \[out :: dev.sumocoders.be\] //g')
echo "Database: $database"
echo "User: $user"
echo "Password: $pass"
echo -e "Please press return when the installation has successfully completed. If you have problems with the installer, enter 'sumo box ssh' and do composer install in the project folder"
read input_variable

php tools/install_locale.php -f src/Frontend/Themes/Bootstrap/locale.xml

cp app/config/parameters.yml app/config/parameters.dev.yml
sed -i '' -e 's/database.host:.*/database.host:          localhost/g' app/config/parameters.dev.yml
sed -i '' -e 's/database.user:.*/database.user:          '$user'/g' app/config/parameters.dev.yml
sed -i '' -e 's/database.password:.*/database.password:      '$pass'/g' app/config/parameters.dev.yml
sed -i '' -e 's/site.domain:.*/site.domain:            '$project'.'$client'.sumocoders.eu/g' app/config/parameters.dev.yml

cap deploy:setup deploy
cap sumodev:db:put
scp app/config/parameters.dev.yml sites@dev.sumocoders.eu:~/apps/$client/$project/shared/config/parameters.yml

open http://$project.$client.sumocoders.eu/
echo -e "Please check whether the site is working correctly on staging."
read input_variable

rm app/config/parameters.dev.yml
cap sumodev:db:lock

cp -r src/Frontend/Themes/Bootstrap src/Frontend/Themes/Custom
sed -i '' -e 's|.*<name>bootstrap</name>.*|  <name>custom</name>|g' src/Frontend/Themes/Custom/info.xml
sed -i '' -e 's/set :theme.*/set :theme, "Custom"/g' Capfile
sed -i '' -e 's/.*"theme":.*/  "theme": "Custom",/g' package.json

git add .
git commit -m 'Duplicate Bootstrap theme'
git push

grunt build
cap deploy

open http://$project.$client.sumocoders.eu/private/nl/extensions/themes
echo -e "The custom theme has been uploaded. Log in to the backend and install the new custom theme. Press return when you're done."
read input_variable

cap sumodev:db:get

echo -e "All done!"

