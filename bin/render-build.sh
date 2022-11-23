#!/usr/bin/env bash
# exit on error
set -o errexit

# Build commands for front end to create the production build
rm -rf public
npm install --prefix client && npm run build --prefix client
cp -a client/build/. public/

# Build commands for back end
bundle install
bundle exec rake db:migrate 
bundle exec rake db:seed # if you have seed data, run this command for the initial deploy only to avoid duplicate records

# Initial Render.com build commands
# bundle install; bundle exec rake assets:precompile; bundle exec rake assets:clean;
# changed to: ./bin/render-build.sh

# Initial Render.com start commands
# bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
# changed to: bundle exec puma -C config/puma.rb