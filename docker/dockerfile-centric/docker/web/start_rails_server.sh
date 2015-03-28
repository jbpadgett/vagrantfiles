#!/bin/bash

# start your rails server
cd /myapp
bundle install

# start passenger with builtin web server (no nginx/apache)
bundle exec passenger start --engine=builtin -p 3000








