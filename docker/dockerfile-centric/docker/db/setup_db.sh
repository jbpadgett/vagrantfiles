#!/bin/bash

cd /myapp
#Run rails db setup steps
bundle exec rake db:drop db:create db:migrate
