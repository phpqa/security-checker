#!/bin/sh
set -e

isCommand() {
  for cmd in \
    "help" \
    "list" \
    "security:check"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

if [ "${1:0:1}" = "-" ]; then
  set -- /sbin/tini -- php /vendor/bin/security-checker "$@"
elif [ "$1" = "/vendor/bin/security-checker" ]; then
  set -- /sbin/tini -- php "$@"
elif [ "$1" = "security-checker" ]; then
  set -- /sbin/tini -- php /vendor/bin/"$@"
elif isCommand "$1"; then
  set -- /sbin/tini -- php /vendor/bin/security-checker "$@"
fi

exec "$@"
