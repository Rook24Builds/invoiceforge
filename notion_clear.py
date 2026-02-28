import requests
import json

API_KEY = "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"
PAGE_ID = "31365823-28c7-81d5-81cc-de0fecd99b84"
HEADERS = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json",
    "Notion-Version": "2022-06-28"
}

# Get all blocks
url = f"https://api.notion.com/v1/blocks/{PAGE_ID}/children"
resp = requests.get(url, headers=HEADERS, timeout=30)
data = resp.json()

print(f"Found {len(data.get('results', []))} blocks")

# Delete blocks
for block in data.get("results", []):
    block_id = block["id"]
    delete_url = f"https://api.notion.com/v1/blocks/{block_id}"
    try:
        requests.delete(delete_url, headers=HEADERS, timeout=10)
        print(f"Deleted {block_id}")
    except Exception as e:
        print(f"Error deleting {block_id}: {e}")

print("Done clearing blocks")
