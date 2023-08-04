#!/bin/bash

# Protects script from continuing with an error
set -eu -o pipefail

# Ensures environment variables are set
export DOCKER_INFLUXDB_INIT_MODE=$DOCKER_INFLUXDB_INIT_MODE
export DOCKER_INFLUXDB_INIT_USERNAME=$DOCKER_INFLUXDB_INIT_USERNAME
export DOCKER_INFLUXDB_INIT_PASSWORD=$DOCKER_INFLUXDB_INIT_PASSWORD
export DOCKER_INFLUXDB_INIT_ORG=$DOCKER_INFLUXDB_INIT_ORG
export DOCKER_INFLUXDB_INIT_BUCKET=$DOCKER_INFLUXDB_INIT_BUCKET
export DOCKER_INFLUXDB_INIT_RETENTION=$DOCKER_INFLUXDB_INIT_RETENTION
export DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=$DOCKER_INFLUXDB_INIT_ADMIN_TOKEN
export DOCKER_INFLUXDB_INIT_PORT=$DOCKER_INFLUXDB_INIT_PORT
export DOCKER_INFLUXDB_INIT_HOST=$DOCKER_INFLUXDB_INIT_HOST
export DOCKER_INFLUXDB_V1_USERNAME=$DOCKER_INFLUXDB_V1_USERNAME
export DOCKER_INFLUXDB_V1_PASSWORD=$DOCKER_INFLUXDB_V1_PASSWORD


# Conducts initial InfluxDB using the CLI
influx setup --skip-verify --bucket ${DOCKER_INFLUXDB_INIT_BUCKET} --retention ${DOCKER_INFLUXDB_INIT_RETENTION} --token ${DOCKER_INFLUXDB_INIT_ADMIN_TOKEN} --org ${DOCKER_INFLUXDB_INIT_ORG} --username ${DOCKER_INFLUXDB_INIT_USERNAME} --password ${DOCKER_INFLUXDB_INIT_PASSWORD} --host http://${DOCKER_INFLUXDB_INIT_HOST}:${DOCKER_INFLUXDB_INIT_PORT} --force

#Create InfluxCLI Config for authentication
influx config create -a -n config-name -u http://${DOCKER_INFLUXDB_INIT_HOST}:${DOCKER_INFLUXDB_INIT_PORT} -t ${DOCKER_INFLUXDB_INIT_ADMIN_TOKEN} -o ${DOCKER_INFLUXDB_INIT_ORG}

#Retrieve bucket ID for INIT_BUCKET
export BUCKET_ID="$(influx bucket list --hide-headers --name ${DOCKER_INFLUXDB_INIT_BUCKET} | awk '{print $1}')"

#https://docs.influxdata.com/influxdb/v2.3/reference/cli/influx/v1/auth/create/
influx v1 auth create --host http://${DOCKER_INFLUXDB_INIT_HOST}:${DOCKER_INFLUXDB_INIT_PORT} -o ${DOCKER_INFLUXDB_INIT_ORG} --username ${DOCKER_INFLUXDB_V1_USERNAME} --password ${DOCKER_INFLUXDB_V1_PASSWORD} --write-bucket ${BUCKET_ID}


#Update fields and run from host to map unmapped buckets to a database
    #https://ivanahuckova.medium.com/setting-up-influxdb-v2-flux-with-influxql-in-grafana-926599a19eeb

# curl --request POST http://localhost:8086/api/v2/dbrps \
#   --header "Authorization: Token YourAuthToken" \
#   --header 'Content-type: application/json' \
#   --data '{
#         "bucketID": "00oxo0oXx000x0Xo",
#         "database": "example-db",
#         "default": true,
#         "orgID": "00oxo0oXx000x0Xo",
#         "retention_policy": "example-rp"
#       }'

#!/bin/bash

# Protects script from continuing with an error
set -eu -o pipefail

# Ensures environment variables are set
export DOCKER_INFLUXDB_INIT_MODE=$DOCKER_INFLUXDB_INIT_MODE
export DOCKER_INFLUXDB_INIT_USERNAME=$DOCKER_INFLUXDB_INIT_USERNAME
export DOCKER_INFLUXDB_INIT_PASSWORD=$DOCKER_INFLUXDB_INIT_PASSWORD
export DOCKER_INFLUXDB_INIT_ORG=$DOCKER_INFLUXDB_INIT_ORG
export DOCKER_INFLUXDB_INIT_BUCKET=$DOCKER_INFLUXDB_INIT_BUCKET
export DOCKER_INFLUXDB_INIT_RETENTION=$DOCKER_INFLUXDB_INIT_RETENTION
export DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=$DOCKER_INFLUXDB_INIT_ADMIN_TOKEN
export DOCKER_INFLUXDB_INIT_PORT=$DOCKER_INFLUXDB_INIT_PORT
export DOCKER_INFLUXDB_INIT_HOST=$DOCKER_INFLUXDB_INIT_HOST
export DOCKER_INFLUXDB_V1_USERNAME=$DOCKER_INFLUXDB_V1_USERNAME
export DOCKER_INFLUXDB_V1_PASSWORD=$DOCKER_INFLUXDB_V1_PASSWORD


# Conducts initial InfluxDB using the CLI
influx setup --skip-verify --bucket ${DOCKER_INFLUXDB_INIT_BUCKET} --retention ${DOCKER_INFLUXDB_INIT_RETENTION} --token ${DOCKER_INFLUXDB_INIT_ADMIN_TOKEN} --org ${DOCKER_INFLUXDB_INIT_ORG} --username ${DOCKER_INFLUXDB_INIT_USERNAME} --password ${DOCKER_INFLUXDB_INIT_PASSWORD} --host http://${DOCKER_INFLUXDB_INIT_HOST}:${DOCKER_INFLUXDB_INIT_PORT} --force

#Create InfluxCLI Config for authentication
influx config create -a -n config-name -u http://${DOCKER_INFLUXDB_INIT_HOST}:${DOCKER_INFLUXDB_INIT_PORT} -t ${DOCKER_INFLUXDB_INIT_ADMIN_TOKEN} -o ${DOCKER_INFLUXDB_INIT_ORG}

#Retrieve bucket ID for INIT_BUCKET
export BUCKET_ID="$(influx bucket list --hide-headers --name ${DOCKER_INFLUXDB_INIT_BUCKET} | awk '{print $1}')"

#https://docs.influxdata.com/influxdb/v2.3/reference/cli/influx/v1/auth/create/
influx v1 auth create --host http://${DOCKER_INFLUXDB_INIT_HOST}:${DOCKER_INFLUXDB_INIT_PORT} -o ${DOCKER_INFLUXDB_INIT_ORG} --username ${DOCKER_INFLUXDB_V1_USERNAME} --password ${DOCKER_INFLUXDB_V1_PASSWORD} --write-bucket ${BUCKET_ID}


#Update fields and run from host to map unmapped buckets to a database
    #https://ivanahuckova.medium.com/setting-up-influxdb-v2-flux-with-influxql-in-grafana-926599a19eeb

# curl --request POST http://localhost:8086/api/v2/dbrps \
#   --header "Authorization: Token YourAuthToken" \
#   --header 'Content-type: application/json' \
#   --data '{
#         "bucketID": "00oxo0oXx000x0Xo",
#         "database": "example-db",
#         "default": true,
#         "orgID": "00oxo0oXx000x0Xo",
#         "retention_policy": "example-rp"
#       }'


#Example
# curl --request POST http://localhost:8086/api/v2/dbrps \
#   --header "Authorization: Token changeme" \
#   --header 'Content-type: application/json' \
#   --data '{
#         "bucketID": "6aa7aeeac371c5aa",
#         "database": "test",
#         "default": true,
#         "orgID": "be1300ecfc0fc866",
#         "retention_policy": "4d"
#       }'