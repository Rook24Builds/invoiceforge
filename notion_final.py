import requests
import json
import time

API_KEY = "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"
PAGE_ID = "31365823-28c7-81d5-81cc-de0fecd99b84"
BASE_URL = "https://api.notion.com/v1"

HEADERS = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json",
    "Notion-Version": "2022-06-28"
}

def api_request(method, endpoint, data=None, retries=3):
    """Make API request with retries."""
    url = f"{BASE_URL}{endpoint}"
    
    for attempt in range(retries):
        try:
            if method == "GET":
                resp = requests.get(url, headers=HEADERS, timeout=30)
            elif method == "DELETE":
                resp = requests.delete(url, headers=HEADERS, timeout=30)
            elif method == "PATCH":
                resp = requests.patch(url, headers=HEADERS, json=data, timeout=30)
            else:
                raise ValueError(f"Unknown method: {method}")
            
            if resp.status_code in [200, 204]:
                return resp.json() if resp.status_code == 200 else None
            elif resp.status_code == 429:
                print(f"Rate limited, waiting...")
                time.sleep(2)
                continue
            else:
                print(f"Error: {resp.status_code} - {resp.text[:200]}")
                time.sleep(1)
        except Exception as e:
            print(f"Exception: {e}")
            time.sleep(1)
    
    return None

def clear_page():
    """Delete all blocks from page."""
    print("Clearing existing content...")
    
    result = api_request("GET", f"/blocks/{PAGE_ID}/children")
    if not result:
        return
    
    blocks = result.get("results", [])
    print(f"Found {len(blocks)} blocks to delete")
    
    for i, block in enumerate(blocks):
        block_id = block["id"]
        api_request("DELETE", f"/blocks/{block_id}")
        if (i + 1) % 10 == 0:
            print(f"Deleted {i+1}/{len(blocks)}")
        time.sleep(0.1)
    
    print("Page cleared!")

def create_heading_1(text):
    return {
        "object": "block",
        "type": "heading_1",
        "heading_1": {
            "rich_text": [{"type": "text", "text": {"content": text}}]
        }
    }

def create_heading_2(text):
    return {
        "object": "block",
        "type": "heading_2",
        "heading_2": {
            "rich_text": [{"type": "text", "text": {"content": text}}]
        }
    }

def create_heading_3(text):
    return {
        "object": "block",
        "type": "heading_3",
        "heading_3": {
            "rich_text": [{"type": "text", "text": {"content": text}}]
        }
    }

def create_paragraph(text):
    return {
        "object": "block",
        "type": "paragraph",
        "paragraph": {
            "rich_text": [{"type": "text", "text": {"content": text[:1900]}}]
        }
    }

def create_callout(text, icon="💡"):
    return {
        "object": "block",
        "type": "callout",
        "callout": {
            "rich_text": [{"type": "text", "text": {"content": text}}],
            "icon": {"type": "emoji", "emoji": icon}
        }
    }

def create_bullet(text):
    return {
        "object": "block",
        "type": "bulleted_list_item",
        "bulleted_list_item": {
            "rich_text": [{"type": "text", "text": {"content": text}}]
        }
    }

def create_numbered(text):
    return {
        "object": "block",
        "type": "numbered_list_item",
        "numbered_list_item": {
            "rich_text": [{"type": "text", "text": {"content": text}}]
        }
    }

def create_divider():
    return {
        "object": "block",
        "type": "divider",
        "divider": {}
    }

def parse_markdown(content):
    """Parse markdown into Notion blocks."""
    blocks = []
    lines = content.split('\n')
    
    in_toggle = False
    in_callout = False
    callout_lines = []
    callout_icon = "💡"
    
    for line in lines:
        stripped = line.strip()
        
        # Skip markers
        if stripped.startswith('=== TOGGLE'): 
            in_toggle = True
            continue
        if stripped.startswith('=== END TOGGLE'):
            in_toggle = False
            continue
        if stripped.startswith('=== CALLOUT'):
            in_callout = True
            callout_lines = []
            continue
        if stripped.startswith('=== END CALLOUT'):
            in_callout = False
            if callout_lines:
                text = '\\n'.join(callout_lines)
                blocks.append(create_callout(text, callout_icon))
            continue
        
        if in_toggle or in_callout:
            if in_callout:
                callout_lines.append(stripped)
            continue
        
        if not stripped or stripped.startswith('===') or stripped.startswith('---') or stripped.startswith('<!--'):
            continue
        
        # Headings
        if stripped.startswith('# ') and not stripped.startswith('##'):
            blocks.append(create_heading_1(stripped[2:]))
        elif stripped.startswith('##'):
            blocks.append(create_heading_2(stripped[3:]))
        elif stripped.startswith('### '):
            blocks.append(create_heading_3(stripped[4:]))
        # Bullet
        elif stripped.startswith('- ') or stripped.startswith('* '):
            blocks.append(create_bullet(stripped[2:]))
        # Quote/callout
        elif stripped.startswith('> '):
            blocks.append(create_callout(stripped[2:]))
        # Tables (skip complex parsing for now, just use text)
        elif '|' in stripped and not stripped.endswith('|'):
            # Table rows - skip separator, keep content
            cells = [c.strip() for c in stripped.split('|')[1:-1] if c.strip()]
            if cells:
                blocks.append(create_paragraph(' | '.join(cells)))
        # Regular paragraph
        elif stripped:
            blocks.append(create_paragraph(stripped))
    
    return blocks

def upload_blocks(blocks):
    """Upload blocks in batches."""
    print(f"Uploading {len(blocks)} blocks...")
    
    url = f"{BASE_URL}/blocks/{PAGE_ID}/children"
    
    for i in range(0, len(blocks), 100):
        batch = blocks[i:i+100]
        payload = {"children": batch}
        
        resp = requests.patch(url, headers=HEADERS, json=payload, timeout=60)
        if resp.status_code == 200:
            print(f"Uploaded batch {i//100 + 1} ({len(batch)} blocks)")
        else:
            print(f"Error in batch {i//100 + 1}: {resp.status_code}")
            print(resp.text[:500])
        
        time.sleep(0.5)  # Rate limit
    
    print("Upload complete!")

def main():
    # Read README
    print("Reading README...")
    with open('operations-hub/content/invoiceforge-readme-notion.md', 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Clear existing content
    clear_page()
    
    # Parse content
    print("\nParsing content...")
    blocks = parse_markdown(content)
    print(f"Created {len(blocks)} blocks")
    
    # Upload
    print("\nUploading to Notion...")
    upload_blocks(blocks)
    
    print(f"\n✅ Done!")
    print(f"View at: https://notion.so/{PAGE_ID.replace('-', '')}")

if __name__ == "__main__":
    main()
