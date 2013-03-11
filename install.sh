#!/bin/bash

# install bootstrap
wget http://twitter.github.com/bootstrap/assets/bootstrap.zip
unzip bootstrap.zip
rm bootstrap.zip
mv bootstrap/js/* app/assets/javascripts/
mv bootstrap/css/* app/assets/stylesheets/
rm -rf bootstrap/

# install jquery
wget http://code.jquery.com/jquery-latest.min.js
mv jquery-latest.min.js app/assets/javascripts/jquery.js

# install jquery JSONP
wget https://github.com/jaubourg/jquery-jsonp
mv jquery-jsonp app/assets/javascripts/jquery.jsonp.js

# compile LESS files to CSS
lessc -x public/less/style.less app/assets/stylesheets/style.css
