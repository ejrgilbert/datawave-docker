#!/bin/bash

# Run all startup scripts
/opt/docker_utils/run-parts.sh
# Wait until necessary services are available before continuing
/opt/docker_utils/wait.sh

if [ -z "$1" ]; then
  echo "[ERROR] Specify command to run."
  exit 1
fi

eval "$@"

tail -F /keep/me/running >/dev/null 2>&1