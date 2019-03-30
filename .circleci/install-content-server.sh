#!/bin/bash -ex

if grep -e "fxa-content-server" -e 'all' ../test.list; then
  sudo apt-get install -y graphicsmagick
  # npm i --production; npm i; cp server/config/local.json-dist server/config/local.json; cd ..

  # cd fxa-auth-server; npm i; node ./scripts/gen_keys.js; node ./scripts/gen_vapid_keys.js; node ./fxa-oauth-server/scripts/gen_keys; cd ..

  # cd fxa-auth-db-mysql; npm i; cd ..

  # cd fxa-auth-server; sudo npm link ../fxa-auth-db-mysql; cd ..

  # # cd fxa-email-service; cargo build --bin fxa_email_send; cd ..

  # # cd browserid-verifier; npm i; cd ..

  # # cd fxa-auth-server/fxa-oauth-server; npm i; cd ../..

  # cd fxa-profile-server; npm i; mkdir -p var/public/; cd ..

  # cd fxa-basket-proxy; npm i; cd ..

  # cd 123done; npm i; cd ..

  # cd fxa-content-server

  # CONFIG_FILES=server/config/local.json,server/config/production.json npx grunt build
  cd ..
  CIRCLECI=false npm install
else
  exit 0;
fi
