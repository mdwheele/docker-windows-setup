#!/usr/bin/env bash
[ "$DEBUG" = "true" ] && set -x
set -e

UID_DEFAULT=$(id -u www-data)

# Here we check if GID and UID are already defined properly or not
# i.e Do we have a volume mounted and with a different uid/gid ?
if [[ -z "$(ls -n /var/www/persona | grep $UID_DEFAULT)" ]]; then
    if [ "$UID" != "0" ] && [ "$UID" != "$(id -u www-data)" ]; then
      echo "Need to change UID and GID."
      usermod  -u $UID www-data
      groupmod -g $GID www-data
      chown -R www-data:www-data /var/www
      echo "UID and GID changed to $UID and $GID."
    fi
else
    echo "UID and GID are OK !"
fi

if ! id -u $USER > /dev/null 2>&1; then
    echo "Creating user matching host user..."
    useradd -u $UID -g $GID -o -m -r $USER
fi

echo "Setting www-data home directory to host user..."
usermod -d /home/$USER www-data

echo "Setting www-data shell to /bin/bash..."
usermod -s /bin/bash www-data

exec "$@"