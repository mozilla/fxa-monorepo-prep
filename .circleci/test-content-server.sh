#!/bin/bash -lex

MODULE=$(basename $(pwd))
PAIRING=$1
DIR=$(dirname "$0")

if grep -e "$MODULE" -e 'all' $DIR/../packages/test.list; then

  # docker pull mysql/mysql-server:5.6 && docker run -d --name=mydb -e MYSQL_ALLOW_EMPTY_PASSWORD=true -e MYSQL_ROOT_HOST=% -p 3306:3306 mysql/mysql-server:5.6

  # docker pull memcached && docker run -d --name memcached -p 11211:11211 memcached

  # docker pull redis && docker run -d --name redis-server -p 6379:6379 redis

  # docker pull mozilla/fxa-email-service:v1.130.0 && docker run -d --name fxa-email-service -p 8001:8001 -e FXA_EMAIL_HMACKEY=hyperthink -e FXA_EMAIL_SECRETKEY=Y1zCba9PTAGSa7tSOW9Li9HmwLP3aVAY/6fynDm43qQ= mozilla/fxa-email-service:v1.130.0

  # mkdir -p ../logs
  # LOG_LEVEL=error node ../fxa-auth-db-mysql/bin/mem.js &> ../logs/fxa-auth-db-mysql.log &

  # cd ../fxa-auth-server
  # SIGNIN_UNBLOCK_ALLOWED_EMAILS="^block.*@restmail\\.net$" SIGNIN_UNBLOCK_FORCED_EMAILS="^block.*@restmail\\.net$" npm start &> ../logs/fxa-auth-server.log &
  # LOG_LEVEL=error NODE_ENV=dev node ./fxa-oauth-server/bin/server.js &> ../logs/fxa-oauth-server.log &
  # cd ..

  # cd fxa-profile-server
  # LOG_LEVEL=error NODE_ENV=dev npm start &> ../logs/fxa-profile-server.log &
  # cd ..

  # npm i vladikoff/browserid-verifier#http &> /dev/null
  # cd node_modules/browserid-verifier
  # npm i &> /dev/null
  # PORT=5050 CONFIG_FILES=../../fxa-content-server/tests/ci/config_verifier.json node server.js &> ../../logs/browserid-verifier.log &
  # cd ../../
  # cd browserid-verifier
  # PORT=5050 CONFIG_FILES=../fxa-content-server/tests/ci/config_verifier.json node server.js &> ../logs/browserid-verifier.log &
  # cd ..

  # cd fxa-content-server
  # CONFIG_FILES=server/config/local.json,server/config/production.json npx grunt serverproc:dist &> ../logs/fxa-content-server.log &

  # sleep 5
  # CONFIG_FILES=server/config/local.json,server/config/production.json,tests/ci/config_circleci.json npx grunt serverproc:dist &

  sudo apt-get install -y python-setuptools python-dev build-essential graphicsmagick &> /dev/null
  sudo easy_install pip &> /dev/null
  sudo pip install mozdownload mozinstall &> /dev/null

  if [[ ! $(which rustup) ]]; then
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    PATH=$PATH:$HOME/.cargo/bin/
  fi

  cd ..
  npx pm2 delete servers.json && npx pm2 start servers.json
  sleep 5
  cd fxa-content-server

  if [ -n "${PAIRING}" ]; then
    wget https://s3-us-west-2.amazonaws.com/fxa-dev-bucket/fenix-pair/desktop/7f10c7614e9fa46-target.tar.bz2
    mozinstall 7f10c7614e9fa46-target.tar.bz2
    node tests/intern.js --suites=pairing --firefoxBinary=./firefox/firefox
    # todo test-travis test-server
  else
    mozdownload --version 58.0 --destination firefox.tar.bz2
    mozinstall firefox.tar.bz2

    node ./tests/intern.js --suites=circle --firefoxBinary=./firefox/firefox
  fi
else
  exit 0;
fi
