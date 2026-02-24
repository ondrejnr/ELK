#!/bin/bash
KIBANA_URL="http://localhost:5601"

echo "Waiting for Kibana..."
until curl -s "$KIBANA_URL/api/status" | grep -q '"level":"available"'; do
  sleep 2
done

echo "Kibana is ready! Creating Index Pattern..."

# 1. Create Index Pattern for fluentd-*
curl -X POST "$KIBANA_URL/api/saved_objects/index-pattern/fluentd-pattern" \
  -H 'kbn-xsrf: true' \
  -H 'Content-Type: application/json' \
  -d '{"attributes": {"title": "fluentd-*", "timeFieldName": "@timestamp"}}'

echo "Creating Runtime Fields..."
# 2. Pridanie Response Category (Fast/Normal/Slow)
curl -X POST "$KIBANA_URL/api/index_patterns/index-pattern/fluentd-pattern/runtime_field" \
  -H 'kbn-xsrf: true' \
  -H 'Content-Type: application/json' \
  -d '{
    "runtimeField": {
      "type": "keyword",
      "script": "if (doc[\"request_time\"].size() != 0) { def res = doc[\"request_time\"].value; if (res < 0.2) return \"Fast\"; if (res < 0.5) return \"Normal\"; return \"Slow\"; } return \"Unknown\";"
    }
  }'

echo "Setup Complete!"
