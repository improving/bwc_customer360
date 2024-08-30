docker run \
  --pull=always \
  --env-file ../license.env \
  -p 8080:8080 \
  -v $(pwd)/config:/config \
  -v $(pwd)/../../kafka-environment/schemas:/schemas \
  shadowtraffic/shadowtraffic:latest \
  --config /config/config-avro.json \
  --with-studio \
  --watch \
  --sample 1000 \
  --stdout \
