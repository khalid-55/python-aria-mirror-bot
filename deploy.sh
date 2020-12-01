#!/bin/bash

if [ "$1" == "" ] ; then
    echo "$(basename "$0") [-h] [appname] -- a script to deploy to heroku

where:
    -h - show this help text
    appname - The heroku appname"
    exit 0
fi

heroku login
heroku create $1
heroku git:remote -a $1
heroku addons:create heroku-postgresql
git add -f credentials.json token.pickle config.env heroku.yml
git commit -m "Added Creds."
git push heroku master --force
heroku ps:scale worker=0
heroku ps:scale worker=1
