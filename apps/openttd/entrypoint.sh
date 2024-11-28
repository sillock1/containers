#!/bin/bash

declare save
autosave=`find /config/save/autosave -regex ".*autosave[0-9]+\.sav" 2>/dev/null`

echo $autosave

if [ -z ${SAVEFILE} ]; then
  echo "Loading save ${latestAutosave}"
  save = ${SAVEFILE}
elif [ ! -z ${autosave} ]; then
  echo "Loading autosave file ${autosave}"
  save=$autosave
else
  echo "No autosave found and no specific save file passed"
fi

exec /app/openttd/openttd -c /config/openttd.cfg -D -g ${save} -x "$@"
