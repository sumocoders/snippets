#!/bin/bash

mkdir -p ~/Sites/$2/$3
cd ~/Sites/$2/$3
git clone git://github.com/sumocoders/forkcms.git .
rm -rf .git
git init
git add .
git commit -m 'initial commit'
git remote add origin $1
git push --set-upstream origin master
git checkout -b staging
git push --set-upstream origin staging
echo -e "You will now be taken to Gitlab. Please set the default branch to 'staging'. Press enter when you're done."
read input_variable
open http://git.sumocoders.be/sumocoders/$3/edit

sed -i -e 's/set :client,  ""/set :client, "'$2'"/g' Capfile
sed -i -e 's/set :project, ""/set :project, "'$3'"/g' Capfile
sed -i -e 's|set :repository, ""|set :repository, "'$1'"|g' Capfile

sed -i -e 's|site.path_www:          </home/sites/<client>/<project>path>|site.path_www:          /home/sites/'$2'/'$3'|g' app/config/parameters_install.yml

git add .
git commit -m 'Added basic project info to be able to deploy'
git push

bundle install
cap sumodev:db:create
cap sumodev:db:get

composer install
npm install
grunt build

echo -e "The Fork installer will now be opened. The database settings will be printed below."
open http://$3.$2.dev/
database=$(cap sumodev:db:info 2>&1 | grep database -A 2 | tail -n 1 | sed -e 's/ \*\* \[out :: dev.sumocoders.be\] //g')
user=$(cap sumodev:db:info 2>&1 | grep user -A 3 | tail -n 1 | sed -e 's/ \*\* \[out :: dev.sumocoders.be\] //g')
pass=$(cap sumodev:db:info 2>&1 | grep pass -A 3 | tail -n 1 | sed -e 's/ \*\* \[out :: dev.sumocoders.be\] //g')
echo "Database: $database"
echo "User: $user"
echo "Password: $pass"
echo -e "Please press enter when the installation has successfully completed. If you have problems with the installer, enter 'sumo box ssh' and do composer install in the project folder"
read input_variable

open http://$3.$2.dev/private
echo -e "Now import the locale.xml from the theme folder to the translations. Press enter when you're done"
read input_variable

cp app/config/parameters.yml app/config/parameters.dev.yml
sed -i -e 's/database.host:          10.11.12.13/database.host:          localhost/g' app/config/parameters.dev.yml
sed -i -e 's/database.user:          root/database.user:          '$user'/g' app/config/parameters.dev.yml
sed -i -e 's/database.password:      root/database.password:      '$pass'/g' app/config/parameters.dev.yml
sed -i -e 's/site.domain:            '$3'.'$2'.dev/site.domain:            '$3'.'$2'.sumocoders.eu/g' app/config/parameters.dev.yml

cap deploy:setup deploy
cap sumodev:db:put
scp app/config/parameters.dev.yml sites@dev.sumocoders.eu:~/apps/$2/$3/shared/config/parameters.yml

open http://$3.$2.sumocoders.eu/
echo -e "Please check whether the site is working correctly on staging."
read input_variable

rm app/config/parameters.dev.yml
cap sumodev:db:lock
