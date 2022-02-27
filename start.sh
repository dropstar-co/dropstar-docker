#!/bin/bash
set -e
source .env

pushd dropstar-api-db
    ./postgres_ssl.sh
popd

docker-compose up -d db



POSTGRES_URL="postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"

if [ ! -d "dropstar-api" ]; then
    git clone git@github.com:etinxdev/dropstar-api.git
fi

pushd dropstar-api
    git checkout develop
    git pull
    npm install
popd

pushd dropstar-api/src/database
    echo "TEST_URL=${POSTGRES_URL}"      > .env
    echo "DATABASE_URL=${POSTGRES_URL}" >> .env
    npx sequelize db:migrate
popd