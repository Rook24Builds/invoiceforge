#!/usr/bin/env python3
"""
Notion workspace reconnaissance tool
Scans existing workspace structure before making changes
"""

import os
import requests
import json

def get_workspace_structure():
    # Try multiple ways to get the API key
    api_key = os.getenv('NOTION_API_KEY')
    
    if not api_key:
        print("❌ NOTION_API_KEY not found in environment")
        return None
    
    headers = {
        'Authorization': f'Bearer {api_key}',
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json'
    }
    
    try:
        # Get the workspace ID and user info
        user_response = requests.get('https://api.notion.com/v1/users', headers=headers)
        user_response.raise_for_status()
        
        # Get all workspaces/databases
        search_response = requests.post('https://api.notion.com/v1/search', 
                                     headers=headers,
                                     json={"filter": {"property": "object", "value": "database"}})
        search_response.raise_for_status()
        
        databases = search_response.json().get('results', [])
        
        # Get page structure too
        pages_response = requests.post('https://api.notion.com/v1/search',
                                     headers=headers,
                                     json={"filter": {"property": "object", "value": "page"}})
        pages_response.raise_for_status()
        
        pages = pages_response.json().get('results', [])
        
        return {
            'status': 'success',
            'database_count': len(databases),
            'page_count': len(pages),
            'databases': [
                {
                    'id': db['id'],
                    'title': db['title'][0]['plain_text'] if db.get('title') else 'Untitled',
                    'properties': list(db.get('properties', {}).keys()),
                    'parent': db.get('parent', {})
                }
                for db in databases
            ],
            'pages': [
                {
                    'id': page['id'],
                    'title': page['properties'].get('title', {}).get('title', [{}])[0].get('plain_text', 'Untitled'),
                    'parent': page.get('parent', {})
                }
                for page in pages[:10]  # Limit to first 10 pages
            ]
        }
        
    except requests.exceptions.RequestException as e:
        return {'status': 'error', 'message': str(e)}

if __name__ == "__main__":
    result = get_workspace_structure()
    if result:
        print(json.dumps(result, indent=2))
    else:
        print("Failed to connect to Notion")