docker image prune --force
docker image prune -a --force
docker container prune --filter "until=240h" --force
docker builder prune --force