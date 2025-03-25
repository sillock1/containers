#!/usr/bin/env bash
#shellcheck disable=SC2086

declare save
autosave=`find /data/save/autosave -regex ".*autosave[0-9]+\.sav" | sort -n | tail -n 1 2>/dev/null`

if [ ! -z ${SAVEFILE} ]; then
  echo "Loading save ${save}"
  save=${SAVEFILE}
elif [ ! -z ${autosave} ]; then
  echo "Loading autosave file ${autosave}"
  save=$autosave
else
  echo "No autosave found and no specific save file passed"
fi

envsubst < /app/openttd/private.cfg.tmpl > /data/private.cfg
envsubst < /app/openttd/secrets.cfg.tmpl > /data/secrets.cfg

exec /app/openttd/openttd -c /data/openttd.cfg -D -g ${save} -x "$@"
