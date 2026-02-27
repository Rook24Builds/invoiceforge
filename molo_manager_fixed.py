#!/usr/bin/env python3
"""
Create a proper project task management system in your MOLTBOT Notion page
Uses Notion API 2025-09-03 with correct database creation
"""

import requests
import json
import os

NOTION_API_KEY = "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"
NOTION_VERSION = "2025-09-03"

def create_database():
    url = "https://api.notion.com/v1/databases"
    
    headers = {
        "Authorization": f"Bearer {NOTION_API_KEY}",
        "Notion-Version": NOTION_VERSION,
        "Content-Type": "application/json"
    }
    
    payload = {
        "parent": {
            "page_id": "3036582328c7802d8539ef3df0f36d2a"
        },
        "title": [
            {
                "type": "text",
                "text": {
                    "content": "MoloTasks"
                }
            }
        ],
        "properties": {
            "Task": {
                "title": {}
            },
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
                        {"name": "deployment", "color": "green"},
                        {"name": "testing", "color": "purple"}
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
                        {"name": "P0", "color": "red"},
                        {"name": "P1", "color": "orange"},
                        {"name": "P2", "color": "yellow"},
                        {"name": "P3", "color": "gray"}
                    ]
                }
            },
            "Description": {
                "rich_text": {}
            },
            "OpenCode_Ready": {
                "checkbox": {}
            },
            "OpenCode_Context": {
                "rich_text": {}
            },
            "Estimated_Hours": {
                "number": {},
                "number_format": "number"
            },
            "Actual_Hours": {
                "number": {},
                "number_format": "number"
            }
        }
    }
    
    response = requests.post(url, headers=headers, json=payload)
    print(f"Response: {response.status_code}")
    
    if response.status_code == 200:
        data = response.json()
        print(f"SUCCESS: Database created at {data['url']}")
        return data['id']
    else:
        print(f"Error: {response.text}")
        return None

def create_initial_tasks(database_id):
    url = "https://api.notion.com/v1/pages"
    
    headers = {
        "Authorization": f"Bearer {NOTION_API_KEY}",
        "Notion-Version": NOTION_VERSION,
        "Content-Type": "application/json"
    }
    
    tasks = [
        {
            "parent": {"database_id": database_id},
            "properties": {
                "Task": {"title": [{"text": {"content": "Set up OpenCode integration for MOLTBOT"}}]},
                "Status": {"select": {"name": "planning"}},
                "Phase": {"select": {"name": "integration"}},
                "Type": {"select": {"name": "integration"}},
                "Priority": {"select": {"name": "P1"}},
                "Description": {"rich_text": [{"text": {"content": "Create the OpenCode handler to execute tasks from Notion"}}]},
                "OpenCode_Ready": {"checkbox": False}
            }
        },
        {
            "parent": {"database_id": database_id},
            "properties": {
                "Task": {"title": [{"text": {"content": "Create task execution workflow"}}]},
                "Status": {"select": {"name": "backlog"}},
                "Phase": {"select": {"name": "planning"}},
                "Type": {"select": {"name": "feature"}},
                "Priority": {"select": {"name": "P1"}},
                "Description": {"rich_text": [{"text": {"content": "Design system to track planning through execution phases"}}]},
                "OpenCode_Ready": {"checkbox": False}
            }
        }
    ]
    
    for task in tasks:
        response = requests.post(url, headers=headers, json=task)
        if response.status_code == 200:
            print(f"✓ Created task: {task['properties']['Task']['title'][0]['text']['content']}")
        else:
            print(f"✗ Failed: {response.text}")

if __name__ == "__main__":
    print("Creating MoloTasks database...")
    db_id = create_database()
    if db_id:
        print(f"Creating initial tasks...")
        create_initial_tasks(db_id)
        print("Ready to use with OpenCode integration!")
    else:
        print("Failed to create database")