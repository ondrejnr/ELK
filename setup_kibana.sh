#!/bin/bash
KIBANA_URL="http://localhost:5601"

echo "Waiting for Kibana API (localhost:5601)..."
until curl -s "$KIBANA_URL/api/status" | grep -q 'available'; do
  sleep 5
done

echo "Kibana is ready! Importing complex project..."

# Import NDJSON (Dashboard + Index Pattern + Visualizations)
curl -X POST "$KIBANA_URL/api/saved_objects/_import?overwrite=true" \
  -H "kbn-xsrf: true" \
  --form file=@/app/kibana_project.ndjson

echo "Setup completed successfully!"
