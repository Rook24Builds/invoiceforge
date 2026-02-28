#!/usr/bin/env python3
"""Upload INVOICEFORGE README to Notion with proper block formatting."""

import json
import re
import requests

API_KEY = "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"
PAGE_ID = "31365823-28c7-81d5-81cc-de0fecd99b84"  # START HERE page
HEADERS = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json",
    "Notion-Version": "2022-06-28"
}

def delete_all_blocks():
    """Delete all existing blocks from the page."""
    # Get all blocks
    url = f"https://api.notion.com/v1/blocks/{PAGE_ID}/children"
    response = requests.get(url, headers=HEADERS)
    response.raise_for_status()
    data = response.json()
    
    # Delete each block
    for block in data.get("results", []):
        block_id = block["id"]
        delete_url = f"https://api.notion.com/v1/blocks/{block_id}"
        requests.delete(delete_url, headers=HEADERS)
    
    print(f"Deleted {len(data.get('results', []))} blocks")

def create_rich_text(text, bold=False, italic=False, strikethrough=False, underline=False, code=False, color="default"):
    """Create rich text object."""
    return {
        "type": "text",
        "text": {"content": text, "link": None},
        "annotations": {
            "bold": bold,
            "italic": italic,
            "strikethrough": strikethrough,
            "underline": underline,
            "code": code,
            "color": color
        }
    }

def create_heading_1(text):
    return {
        "object": "block",
        "type": "heading_1",
        "heading_1": {
            "rich_text": [create_rich_text(text)]
        }
    }

def create_heading_2(text):
    return {
        "object": "block",
        "type": "heading_2",
        "heading_2": {
            "rich_text": [create_rich_text(text)]
        }
    }

def create_heading_3(text):
    return {
        "object": "block",
        "type": "heading_3",
        "heading_3": {
            "rich_text": [create_rich_text(text)]
        }
    }

def create_paragraph(text="", bold=False, color="default"):
    rich_text = []
    
    # Parse inline formatting
    # Handle bold with **text**
    parts = re.split(r'(\*\*[^*]+\*\*|\*[^*]+\*|__[^_]+__|_[^_]+_|`[^`]+`)', text)
    
    for part in parts:
        if not part:
            continue
        if part.startswith('**') and part.endswith('**'):
            rich_text.append(create_rich_text(part[2:-2], bold=True))
        elif part.startswith('*') and part.endswith('*') and len(part) > 2:
            rich_text.append(create_rich_text(part[1:-1], italic=True))
        elif part.startswith('`') and part.endswith('`'):
            rich_text.append(create_rich_text(part[1:-1], code=True))
        else:
            rich_text.append(create_rich_text(part))
    
    if not rich_text:
        rich_text = [create_rich_text("")]
    
    return {
        "object": "block",
        "type": "paragraph",
        "paragraph": {
            "rich_text": rich_text,
            "color": color
        }
    }

def create_callout(text, icon="💡"):
    return {
        "object": "block",
        "type": "callout",
        "callout": {
            "rich_text": [create_rich_text(text)],
            "icon": {"type": "emoji", "emoji": icon}
        }
    }

def create_bullet_list_item(text):
    return {
        "object": "block",
        "type": "bulleted_list_item",
        "bulleted_list_item": {
            "rich_text": [create_rich_text(text)]
        }
    }

def create_numbered_list_item(text):
    return {
        "object": "block",
        "type": "numbered_list_item",
        "numbered_list_item": {
            "rich_text": [create_rich_text(text)]
        }
    }

def create_table(headers, rows):
    """Create a table block."""
    table_width = len(headers)
    table = {
        "object": "block",
        "type": "table",
        "table": {
            "table_width": table_width,
            "has_column_header": True,
            "has_row_header": False,
            "children": []
        }
    }
    
    # Add header row
    header_row = {
        "object": "block",
        "type": "table_row",
        "table_row": {
            "cells": [[create_rich_text(h)] for h in headers]
        }
    }
    table["table"]["children"].append(header_row)
    
    # Add data rows
    for row in rows:
        row_cells = []
        for cell in row:
            row_cells.append([create_rich_text(cell)])
        data_row = {
            "object": "block",
            "type": "table_row",
            "table_row": {
                "cells": row_cells
            }
        }
        table["table"]["children"].append(data_row)
    
    return table

def create_divider():
    return {
        "object": "block",
        "type": "divider",
        "divider": {}
    }

def create_toggle(text, children=None):
    block = {
        "object": "block",
        "type": "toggle",
        "toggle": {
            "rich_text": [create_rich_text(text)],
            "children": children or []
        }
    }
    return block

def upload_block_children(blocks):
    """Upload blocks to Notion."""
    url = f"https://api.notion.com/v1/blocks/{PAGE_ID}/children"
    
    # Notion API has a limit of 100 blocks per request
    for i in range(0, len(blocks), 100):
        chunk = blocks[i:i+100]
        payload = {"children": chunk}
        
        response = requests.patch(url, headers=HEADERS, json=payload)
        if response.status_code != 200:
            print(f"Error uploading blocks: {response.text}")
            return False
    
    print(f"Successfully uploaded {len(blocks)} blocks")
    return True

def parse_readme(content):
    """Parse the README markdown and convert to Notion blocks."""
    blocks = []
    lines = content.split('\n')
    
    i = 0
    in_toggle = False
    in_callout = False
    toggle_title = ""
    toggle_content = []
    callout_content = []
    callout_icon = "💡"
    
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        
        # Handle toggle blocks
        if stripped.startswith('=== TOGGLE BLOCK ==='):
            in_toggle = True
            i += 1
            continue
        elif stripped.startswith('=== END TOGGLE ==='):
            in_toggle = False
            if toggle_title:
                toggle_block = create_toggle(toggle_title, toggle_content)
                blocks.append(toggle_block)
            toggle_title = ""
            toggle_content = []
            i += 1
            continue
        
        # Handle callout blocks
        if stripped.startswith('=== CALLOUT BLOCK ==='):
            in_callout = True
            i += 1
            continue
        elif stripped.startswith('=== END CALLOUT ==='):
            in_callout = False
            if callout_content:
                callout_text = '\n'.join(callout_content).strip()
                blocks.append(create_callout(callout_text, callout_icon))
            callout_content = []
            i += 1
            continue
        
        if in_toggle:
            # First line should be the toggle title (starts with **▶**)
            if not toggle_title and stripped.startswith('**▶') or stripped.startswith('**'):
                toggle_title = stripped.strip('*')
            elif stripped:
                # Parse toggle content
                if stripped.startswith('# '):
                    toggle_content.append(create_heading_1(stripped[2:]))
                elif stripped.startswith('## '):
                    toggle_content.append(create_heading_2(stripped[3:]))
                elif stripped.startswith('### '):
                    toggle_content.append(create_heading_3(stripped[4:]))
                elif stripped.startswith('**') or stripped:
                    toggle_content.append(create_paragraph(stripped))
            i += 1
            continue
        
        if in_callout:
            callout_content.append(stripped)
            i += 1
            continue
        
        # Skip certain markers
        if stripped.startswith('===') or stripped.startswith('---') or stripped.startswith('<!--'):
            i += 1
            continue
        
        # Empty lines become dividers or just skipped
        if not stripped:
            i += 1
            continue
        
        # Heading 1
        if stripped.startswith('# ') and not stripped.startswith('## '):
            blocks.append(create_heading_1(stripped[2:]))
            i += 1
            continue
        
        # Heading 2
        if stripped.startswith('## '):
            blocks.append(create_heading_2(stripped[3:]))
            i += 1
            continue
        
        # Heading 3
        if stripped.startswith('### '):
            blocks.append(create_heading_3(stripped[4:]))
            i += 1
            continue
        
        # Blockquote / callout from markdown
        if stripped.startswith('> '):
            text = stripped[2:]
            blocks.append(create_callout(text))
            i += 1
            continue
        
        # Tables
        if '|' in stripped and i + 1 < len(lines) and '|' in lines[i+1]:
            # Start of a table
            table_lines = []
            while i < len(lines) and '|' in lines[i].strip():
                table_lines.append(lines[i].strip())
                i += 1
            
            if len(table_lines) >= 2:  # Need header + separator
                # Parse headers
                header_line = table_lines[0]
                headers = [cell.strip() for cell in header_line.split('|')[1:-1] if cell.strip()]
                
                # Parse rows (skip separator line)
                rows = []
                for table_line in table_lines[2:]:
                    cells = [cell.strip() for cell in table_line.split('|')[1:-1]]
                    if cells and any(cells):
                        # Pad cells to match header length
                        while len(cells) < len(headers):
                            cells.append('')
                        rows.append(cells[:len(headers)])
                
                if headers:
                    blocks.append(create_table(headers, rows))
            continue
        
        # Bullet list
        if stripped.startswith('- ') or stripped.startswith('* '):
            blocks.append(create_bullet_list_item(stripped[2:]))
            i += 1
            continue
        
        # Numbered list
        match = re.match(r'^(\d+)\.\s+(.+)$', stripped)
        if match:
            blocks.append(create_numbered_list_item(match.group(2)))
            i += 1
            continue
        
        # Divider
        if stripped == '---' or stripped.startswith('---'):
            blocks.append(create_divider())
            i += 1
            continue
        
        # Bold text for emphasis
        if stripped.startswith('**') and stripped.endswith('**'):
            blocks.append(create_paragraph(stripped, bold=True))
            i += 1
            continue
        
        # Regular paragraph
        blocks.append(create_paragraph(stripped))
        i += 1
    
    return blocks

def main():
    # Read the README file
    with open('operations-hub/content/invoiceforge-readme-notion.md', 'r', encoding='utf-8') as f:
        content = f.read()
    
    print("Deleting existing blocks...")
    delete_all_blocks()
    
    print("Parsing README content...")
    blocks = parse_readme(content)
    print(f"Parsed {len(blocks)} blocks")
    
    print("Uploading to Notion...")
    success = upload_block_children(blocks)
    
    if success:
        print("\n✅ Successfully uploaded INVOICEFORGE README to Notion!")
        print(f"📄 Page URL: https://www.notion.so/{PAGE_ID.replace('-', '')}")
    else:
        print("\n❌ Failed to upload content")

if __name__ == "__main__":
    main()
