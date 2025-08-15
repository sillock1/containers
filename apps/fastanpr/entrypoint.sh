#!/usr/bin/env bash

exec \
  /usr/local/bin/uvicorn "api:app" \
    --host "0.0.0.0" \
    --port "8000"
