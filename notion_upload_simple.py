#!/usr/bin/env python3
"""Simple version - upload INVOICEFORGE README to Notion."""

import json
import requests

API_KEY = "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"
PAGE_ID = "31365823-28c7-81d5-81cc-de0fecd99b84"
HEADERS = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json",
    "Notion-Version": "2022-06-28"
}

def delete_all_blocks():
    url = f"https://api.notion.com/v1/blocks/{PAGE_ID}/children"
    response = requests.get(url, headers=HEADERS)
    data = response.json()
    
    for block in data.get("results", []):
        block_id = block["id"]
        delete_url = f"https://api.notion.com/v1/blocks/{block_id}"
        requests.delete(delete_url, headers=HEADERS)
    
    print(f"Deleted {len(data.get('results', []))} blocks")

def upload_blocks(blocks):
    url = f"https://api.notion.com/v1/blocks/{PAGE_ID}/children"
    
    for i in range(0, len(blocks), 100):
        chunk = blocks[i:i+100]
        payload = {"children": chunk}
        
        response = requests.patch(url, headers=HEADERS, json=payload)
        if response.status_code != 200:
            print(f"Error: {response.text}")
            return False
        print(f"Uploaded chunk {i//100 + 1}")
    
    print(f"Successfully uploaded {len(blocks)} blocks")
    return True

def main():
    with open('operations-hub/content/invoiceforge-readme-notion.md', 'r', encoding='utf-8') as f:
        content = f.read()
    
    print("Deleting existing blocks...")
    delete_all_blocks()
    
    # Simple blocks - just split by double newline and create paragraphs
    blocks = []
    sections = content.split('\n\n')
    
    for section in sections:
        section = section.strip()
        if not section or section.startswith('===') or section.startswith('---'):
            continue
        
        # Heading 1
        if section.startswith('# ') and not section.startswith('## '):
            text = section[2:]
            blocks.append({
                "object": "block",
                "type": "heading_1",
                "heading_1": {"rich_text": [{"type": "text", "text": {"content": text}}]}
            })
        # Heading 2
        elif section.startswith('## '):
            text = section[3:]
            blocks.append({
                "object": "block",
                "type": "heading_2",
                "heading_2": {"rich_text": [{"type": "text", "text": {"content": text}}]}
            })
        # Heading 3
        elif section.startswith('### '):
            text = section[4:]
            blocks.append({
                "object": "block",
                "type": "heading_3",
                "heading_3": {"rich_text": [{"type": "text", "text": {"content": text}}]}
            })
        # Bullet
        elif section.startswith('- ') or section.startswith('* '):
            text = section[2:]
            blocks.append({
                "object": "block",
                "type": "bulleted_list_item",
                "bulleted_list_item": {"rich_text": [{"type": "text", "text": {"content": text}}]}
            })
        # Regular paragraph
        elif section:
            blocks.append({
                "object": "block",
                "type": "paragraph",
                "paragraph": {"rich_text": [{"type": "text", "text": {"content": section[:2000]}}]}
            })
    
    print(f"Parsed {len(blocks)} blocks")
    
    print("Uploading to Notion...")
    upload_blocks(blocks)
    
    print(f"\nView at: https://www.notion.so/{PAGE_ID.replace('-', '')}")

if __name__ == "__main__":
    main()
