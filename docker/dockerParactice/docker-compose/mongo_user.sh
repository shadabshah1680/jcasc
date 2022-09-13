#!/usr/bin/env bash
echo "Creating mongo users..."
mongo admin --host localhost -u USER_PREVIOUSLY_DEFINED -p PASS_YOU_PREVIOUSLY_DEFINED --eval "db.createUser({user: 'ANOTHER_USER', pwd: 'PASS', roles: [{role: 'readWrite', db: 'xxx'}]}); db.createUser({user: 'admin', pwd: 'PASS', roles: [{role: 'userAdminAnyDatabase', db: 'admin'}]});"
echo "Mongo users created."



ENV MONGO_INITDB_ROOT_USERNAME rootShadab
ENV MONGO_INITDB_ROOT_PASSWORD rootKali
ENV MONGO_INITDB_DATABASE kernal


mongo admin --host localhost -u USER_PREVIOUSLY_DEFINED -p PASS_YOU_PREVIOUSLY_DEFINED --eval "db.createUser({user: 'ANOTHER_USER', pwd: 'PASS', roles: [{role: 'readWrite', db: 'xxx'}]}); db.createUser({user: 'admin', pwd: 'PASS', roles: [{role: 'userAdminAnyDatabase', db: 'admin'}]});"