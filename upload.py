import requests
import time

API_KEY = "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"
PAGE_ID = "31365823-28c7-81d5-81cc-de0fecd99b84"
HEADERS = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json",
    "Notion-Version": "2022-06-28"
}

print("Step 1: Deleting existing blocks...")
url = f"https://api.notion.com/v1/blocks/{PAGE_ID}/children"
resp = requests.get(url, headers=HEADERS)
if resp.status_code == 200:
    blocks = resp.json().get("results", [])
    print(f"Found {len(blocks)} blocks")
    for i, block in enumerate(blocks):
        block_id = block["id"]
        del_url = f"https://api.notion.com/v1/blocks/{block_id}"
        try:
            requests.delete(del_url, headers=HEADERS)
            print(f"Deleted {i+1}/{len(blocks)}", end="\r")
        except:
            pass
        time.sleep(0.1)  # Rate limit
    print("\nBlocks cleared!")
else:
    print(f"Error: {resp.text}")

print("\nStep 2: Reading README...")
with open('operations-hub/content/invoiceforge-readme-notion.md', 'r', encoding='utf-8') as f:
    content = f.read()

print("Step 3: Parsing into blocks...")
blocks = []
lines = content.split('\n')

for line in lines:
    line = line.strip()
    if not line or line.startswith('==') or line.startswith('---') or line.startswith('<!--'):
        continue
    if line.startswith('# ') and not line.startswith('##'):
        blocks.append({"type": "heading_1", "heading_1": {"rich_text": [{"type": "text", "text": {"content": line[2:]}}]}})
    elif line.startswith('##'):
        blocks.append({"type": "heading_2", "heading_2": {"rich_text": [{"type": "text", "text": {"content": line[3:]}}]}})
    elif line.startswith('- ') or line.startswith('* '):
        blocks.append({"type": "bulleted_list_item", "bulleted_list_item": {"rich_text": [{"type": "text", "text": {"content": line[2:]}}]}})
    elif line and not line.startswith('|'):
        blocks.append({"type": "paragraph", "paragraph": {"rich_text": [{"type": "text", "text": {"content": line[:1940]}}]}})

print(f"Created {len(blocks)} blocks")

print("\nStep 4: Uploading to Notion...")
url = f"https://api.notion.com/v1/blocks/{PAGE_ID}/children"
for i in range(0, len(blocks), 100):
    chunk = blocks[i:i+100]
    payload = {"children": [{"object": "block", **b} for b in chunk]}
    resp = requests.patch(url, headers=HEADERS, json=payload)
    if resp.status_code != 200:
        print(f"Error at chunk {i}: {resp.text}")
    else:
        print(f"Uploaded {i+len(chunk)}/{len(blocks)}")
    time.sleep(0.4)

print(f"\nDone! View at: https://notion.so/{PAGE_ID.replace('-', '')}")
