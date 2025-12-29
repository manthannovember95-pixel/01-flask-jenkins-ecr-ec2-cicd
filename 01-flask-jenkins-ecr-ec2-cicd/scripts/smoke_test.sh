#!/usr/bin/env bash
set -euo pipefail

: "${APP_URL:?APP_URL is required}"

echo "Smoke testing: $APP_URL/health"
python - <<'PY'
import os, time, urllib.request, json
url=os.environ["APP_URL"].rstrip("/") + "/health"
for i in range(30):
    try:
        with urllib.request.urlopen(url, timeout=2) as r:
            data=json.loads(r.read().decode())
            if data.get("status") == "ok":
                print("OK:", data)
                raise SystemExit(0)
    except Exception:
        time.sleep(2)
raise SystemExit("Smoke test failed")
PY
