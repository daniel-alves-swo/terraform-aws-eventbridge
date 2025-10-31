import os
import json
from datetime import datetime
import zoneinfo

def lambda_handler(event, context):
    brt = datetime.now(tz=zoneinfo.ZoneInfo("America/Sao_Paulo"))
    msg = {
        "message": f"Hello from Lambda A! Disparo diário ~{os.getenv('TRIGGER_TIME_BRT','08:30')} BRT.",
        "now_brt": brt.isoformat(),
        "event": event
    }
    print(json.dumps(msg))
    return {
        "statusCode": 200,
        "body": json.dumps(msg)
    }
