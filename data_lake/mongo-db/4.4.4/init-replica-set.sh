#!/bin/bash
set -e

# Wait until MongoDB is available
until mongo --eval "print(\"waited for connection\")" > /dev/null 2>&1; do
  echo "Waiting for MongoDB to be available..."
  sleep 5
done

# Initialize the replica set
mongo --eval "rs.initiate({
  \"_id\": \"rs0\",
  \"members\": [
    { \"_id\": 0, \"host\": \"mongo-1:27017\" },
    { \"_id\": 1, \"host\": \"mongo-2:27017\" },
    { \"_id\": 2, \"host\": \"mongo-3:27017\" }
  ]
})"
