VOLUME="$(amixer get Master | tail -n 1 | cut -d '[' -f 2 | sed 's/%.*//g')"
echo "Vol: $VOLUME%"
