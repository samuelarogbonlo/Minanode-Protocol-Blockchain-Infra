from datetime import datetime
import requests
from prometheus_client.parser import text_string_to_metric_families

last_fetched = datetime.now()
families = []

def fetch_families():
    response = requests.get('http://18.206.191.172:9100/metrics')
    global families
    global last_fetched
    if not response:
        return families
    last_fetched = datetime.now()
    metrics = response.text
    families = []
    for family in text_string_to_metric_families(metrics):
        samples = []
        for sample in family.samples:
            samples.append({
                "name": sample[0],
                "labels": sample[1],
                "value": sample[2],
            })
        families.append({
            "name": family.name,
            "documentation": family.documentation,
            "unit": family.unit,
            "type": family.type,
            "samples": samples,
        })
    return families

def get_families():
    """
    Returns last cached values
    """
    return {"last_fetched": str(last_fetched), "families": families}