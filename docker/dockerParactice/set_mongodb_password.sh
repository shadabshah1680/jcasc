#!/bin/bash

# Admin User
MONGODB_ADMIN_USER=ROOT_USER_NAME
MONGODB_ADMIN_PASS=ROOT_PASS_WORD

# Application Database User
MONGODB_APPLICATION_DATABASE=APPLICATION_DATA_BASE
MONGODB_APPLICATION_USER=APPLICATION_USER_NAME
MONGODB_APPLICATION_PASS=APPLICATION_PASS_WORD

# Wait for MongoDB to boot
RET=1
while [[ RET -ne 0 ]]; do
  echo "=> Waiting for confirmation of MongoDB service startup..."
  sleep 5
  mongo admin --eval "help" >/dev/null 2>&1
  RET=$?
done

if [ "$MONGODB_APPLICATION_DATABASE" != "admin" ]; then
  echo "=> Creating an ${MONGODB_APPLICATION_DATABASE} user with a password in MongoDB"
  mongo admin -u $MONGODB_ADMIN_USER -p $MONGODB_ADMIN_PASS <<EOF
use $MONGODB_APPLICATION_DATABASE
db.createUser({user: '$MONGODB_APPLICATION_USER', pwd: '$MONGODB_APPLICATION_PASS', roles:[{role:'dbOwner', db:'$MONGODB_APPLICATION_DATABASE'}]})
EOF

  echo "========================================================================"
  echo "$MONGODB_APPLICATION_USER user created in $MONGODB_APPLICATION_DATABASE! PROTECT the password found in the .env file."
  echo "========================================================================"
else
  echo "=> Skipping App database and user creation."
fi

sleep 1

echo "=> Done!":