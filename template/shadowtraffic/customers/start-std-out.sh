docker run \
  --pull=always \
  --env-file ../license.env \
  -p 8080:8080 \
  -v $(pwd)/config:/config \
  -v $(pwd)/../../kafka-product-team-customer/staging/schemas:/schemas \
  shadowtraffic/shadowtraffic:latest \
  --config /config/config-avro.json \
  # https://docs.shadowtraffic.io/studio
  # http://localhost:8080 -- edit the config-avro.json to see the results in the browser
  --with-studio \
  --watch \
  --sample 1000 \
  --stdout \
