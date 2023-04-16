#!/bin/bash

# Get the current day of the week
day=$(date +%u -u)

next_saturday=$(date -d 'next Saturday' +%s -u)

# Set the time to 21:30
# It is 12:30 in UTC when it is 21:30 in Japan
next_saturday_2130=$(date -d @$next_saturday +%Y-%m-%d\ 12:30 -u)

iso8601_time=$(date -d "$next_saturday_2130" -Iseconds -u)

base_url="https://discord.com/api"
endpoint_url="${base_url}/v${VERSION}/guilds/${GUILD_ID}/scheduled-events"

echo $endpoint_url
echo $iso8601_time

curl -X POST -H 'Content-Type: application/json' -H "Authorization: Bot ${DISCORD_TOKEN}" -d '{"channel_id": "'"$MEETING_ROOM_ID"'", "name": "定例会", "privacy_level": "2", "scheduled_start_time": "'"$iso8601_time"'", "entity_type": "2"}' $endpoint_url