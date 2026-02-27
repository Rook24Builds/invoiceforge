#!/usr/bin/env python3
"""
MoloTask Manager - Direct Notion Integration
Creates project tracking system in MOLTBOT page
"""

import requests
import json
import os

NOTION_TOKEN = "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"
PARENT_PAGE_ID = "3036582328c7802d8539ef3df0f36d2a"

headers = {
    "Authorization": f"Bearer {NOTION_TOKEN}",
    "Notion-Version": "2025-09-03",
    "Content-Type": "application/json"
}

def create_database():
    """Create MoloTasks database in MOLTBOT page"""
    url = "https://api.notion.com/v1/data_sources"
    
    payload = {
        "parent": {
            "type": "page_id",
            "page_id": PARENT_PAGE_ID
        },
        "title": [
            {
                "type": "text",
                "text": {"content": "MoloTasks"}
            }
        ],
        "properties": {
            "Task": {"title": {}},
            "Status": {
                "select": {
                    "options": [
                        {"name": "backlog", "color": "gray"},
                        {"name": "planning", "color": "blue"},
                        {"name": "in_progress", "color": "yellow"},
                        {"name": "review", "color": "purple"},
                        {"name": "done", "color": "green"}
                    ]
                }
            },
            "Phase": {
                "select": {
                    "options": [
                        {"name": "planning", "color": "blue"},
                        {"name": "execution", "color": "orange"},
                        {"name": "testing", "color": "purple"},
                        {"name": "deployment", "color": "green"}
                    ]
                }
            },
            "Type": {
                "select": {
                    "options": [
                        {"name": "feature", "color": "blue"},
                        {"name": "bug", "color": "red"},
                        {"name": "integration", "color": "purple"},
                        {"name": "research", "color": "green"}
                    ]
                }
            },
            "Priority": {
                "select": {
                    "options": [
                        {"name": "p0", "color": "red"},
                        {"name": "p1", "color": "orange"},
                        {"name": "p2", "color": "yellow"},
                        {"name": "p3", "color": "gray"}
                    ]
                }
            },
            "Description": {"rich_text": {}},
            "OpenCode_Ready": {"checkbox": {}},
            "Project_Context": {"rich_text": {}},
            "Next_Action": {"rich_text": {}}
        }
    }
    
    response = requests.post(url, headers=headers, json=payload)
    print(f"Response: {response.status_code}")
    print(f"Response: {response.text}")
    
    if response.status_code == 200:
        data = response.json()
        print(f"Database created: {data['url']}")
        return data['id']
    else:
        print("Failed to create database")
        return None

if __name__ == "__main__":
    print("Creating MoloTasks database in MOLTBOT...")
    create_database()