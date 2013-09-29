#!/bin/sh

#development directory
MEAN_DIR=/usr/local/src/mean

cd $MEAN_DIR

if [ -d "$1" ]; then
	#TODO need to be nice and maybe pull latest code and update?
	echo "update your source from git"
else

	#from here let's now create a new application
	express $1
	cd $1

	#be a good citizen and add in the mongo dep in the package.json file for your application
	mv package.json package_json.orig
	sed '10 i\    "mongoose" : ">= 3.6",' package_json.orig > package.json	

	#run an npm link to all the global packages we installed
	npm link
	

	#create a special bower file to tell bower where to put vendor javascript files
	#files will be under public/javascripts/vendor
	echo '{ "directory" : "public/javascripts/vendor" }' >> .bowerrc

	mkdir public/javascripts/vendor

	#install angular 
	bower install angular --allow-root

	#install bootstrap-css
	bower install bootstrap-css --allow-root

	#install bootstrap-javascript
	bower install bootstrap-javascript --allow-root

	#install angular-bootstrap
	bower install angular-bootstrap --allow-root

	#install angular-scenario for testing
	bower install angular-scenario --allow-root

	#finally change the owner of everything to meandev user and group
	cd $MEAN_DIR
	chown -R meandev:meandev $1	
	
fi

# Create and instantiate init script
touch /etc/init.d/bootForever
echo "#! /bin/sh" >> /etc/init.d/bootForever
echo "# /etc/init.d/bootForever" >> /etc/init.d/bootForever
echo "#" >> /etc/init.d/bootForever
echo "" >> /etc/init.d/bootForever
echo "/usr/local/bin/forever start "$1"/app.js" >> /etc/init.d/bootForever
chmod 755 /etc/init.d/bootForever
update-rc.d /etc/init.d/bootForever defaults

echo "BootScript added"
forever start $1/app.js