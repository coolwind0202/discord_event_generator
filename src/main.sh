#!/bin/bash

# Get the current day of the week
day=$(date +%u -u)

next_sunday=$(date -d 'next Sunday' +%s -u)

# Set the time to 21:00
# It is 12:00 in UTC when it is 21:00 in Japan
next_sunday_2100=$(date -d @$next_sunday +%Y-%m-%d\ 12:00 -u)

iso8601_time=$(date -d "$next_sunday_2100" -Iseconds -u)

base_url="https://discord.com/api"
endpoint_url="${base_url}/v${VERSION}/guilds/${GUILD_ID}/scheduled-events"

echo $endpoint_url
echo $iso8601_time

curl -X POST -H 'Content-Type: application/json' -H "Authorization: Bot ${DISCORD_TOKEN}" -d '{"channel_id": "'"$MEETING_ROOM_ID"'", "name": "定例会", "privacy_level": "2", "scheduled_start_time": "'"$iso8601_time"'", "entity_type": "2"}' $endpoint_url