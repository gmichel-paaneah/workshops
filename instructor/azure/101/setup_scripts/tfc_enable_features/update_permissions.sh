#!/bin/bash

set -eo pipefail

# This reads org names from stdin and makes a request to the TFC admin API
# to enable a "paid features" trial until the end of the year.

# Usage:
#   * grab an api token from TFC with admin access
#   * `export TOKEN=blah`
#   * `./upgrade.sh < one_org_name_per_line.txt`

BASE_URL=https://app.terraform.io
FEATURE_SET_ID=fs-xFJU3Cakg8QyZP5q # Self-Serve Preview
RUNS_CEILING=1
TRIAL_EXPIRATION="2020-02-01T21:06:07.303Z"

if [ -z "$TOKEN" ]; then
  echo "TOKEN is unset. Generate a user token at ${BASE_URL}, then"
  echo "export TOKEN=your-token"
  exit 1
fi

# Ensure we have a functional token
curl \
    --header "Authorization: Bearer $TOKEN" \
    --header "Content-Type: application/vnd.api+json" \
    --silent \
    --fail \
    --show-error \
    "${BASE_URL}/api/v2/ping"
echo "Token is valid"

# Upgrade each organization
while read -r name; do
  printf "Upgrading %s: " "${name}"
  RES=$(curl \
    --request POST \
    --header "Authorization: Bearer $TOKEN" \
    --header "Content-Type: application/vnd.api+json" \
    --silent \
    --fail \
    --show-error \
    --data \
    "{\"data\":{
      \"type\":\"subscription\",
      \"attributes\":{
        \"organization-id\": null,
        \"trial-status\": \"active\",
        \"start-at\": null,
        \"end-at\":\"${TRIAL_EXPIRATION}\",
        \"is-active\": false,
        \"is-current\": false,
        \"is-public\": false
      },
      \"relationships\":{
        \"organization\":{
          \"data\": {\"type\":\"organization\",\"id\":\"${name}\"}
        },
        \"feature-set\":{
          \"data\": {\"type\":\"feature-set\",\"id\":\"${FEATURE_SET_ID}\"}
        }
      }}}" \
    "${BASE_URL}/api/v2/admin/organizations/${name}/subscription"
  )
  echo
  echo "Upgraded ${name}."
  echo
done
