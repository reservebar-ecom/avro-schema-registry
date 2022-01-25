#!/bin/bash

# set the environment from secrets manager
if [ ! -z "${SECRETS_MANAGER_SECRET_ID}" ]; then
  export $(aws secretsmanager get-secret-value \
    --secret-id "${SECRETS_MANAGER_SECRET_ID}" \
    --query 'SecretString' \
    --output text \
    | jq -r 'to_entries|map("\(.key)=\(.value|tostring)")|.[]'\
  )
fi

exec "$@"
