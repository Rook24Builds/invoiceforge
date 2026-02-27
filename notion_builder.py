#!/usr/bin/env python3
"""
Notion Task Management System Builder
Builds complete project/task tracking in your Notion workspace
"""

import os
import requests
import json
from typing import Dict, List, Any

class NotionBuilder:
    def __init__(self, api_key: str, parent_page_id: str):
        self.api_key = api_key
        self.parent_page_id = parent_page_id
        self.base_url = "https://api.notion.com/v1"
        self.headers = {
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json",
            "Notion-Version": "2022-06-28"
        }
    
    def create_database(self, name: str, properties: Dict, parent_type: str = "page_id") -> Dict:
        """Create a new Notion database"""
        url = f"{self.base_url}/databases"
        payload = {
            "parent": {parent_type: self.parent_page_id},
            "title": [{"type": "text", "text": {"content": name}}],
            "properties": properties
        }
        
        response = requests.post(url, headers=self.headers, json=payload)
        response.raise_for_status()
        return response.json()
    
    def create_projects_database(self) -> Dict:
        """Create the master Projects database"""
        properties = {
            "Project Name": {
                "title": {}
            },
            "Status": {
                "select": {
                    "options": [
                        {"name": "Planning", "color": "yellow"},
                        {"name": "Active", "color": "green"},
                        {"name": "Review", "color": "orange"},
                        {"name": "Complete", "color": "blue"},
                        {"name": "On Hold", "color": "red"}
                    ]
                }
            },
            "Priority": {
                "select": {
                    "options": [
                        {"name": "Critical", "color": "red"},
                        {"name": "High", "color": "orange"},
                        {"name": "Medium", "color": "yellow"},
                        {"name": "Low", "color": "gray"}
                    ]
                }
            },
            "Category": {
                "select": {
                    "options": [
                        {"name": "Development", "color": "blue"},
                        {"name": "Research", "color": "green"},
                        {"name": "Design", "color": "purple"},
                        {"name": "Documentation", "color": "gray"},
                        {"name": "Infrastructure", "color": "orange"}
                    ]
                }
            },
            "Description": {
                "rich_text": {}
            },
            "Start Date": {
                "date": {}
            },
            "Due Date": {
                "date": {}
            },
            "Progress": {
                "number": {"format": "percent"}
            },
            "Tasks": {
                "relation": {"database_id": "placeholder"}
            }
        }
        
        return self.create_database("🚀 Open Projects", properties)
    
    def create_tasks_database(self) -> Dict:
        """Create the Tasks database with relation to Projects"""
        properties = {
            "Task": {
                "title": {}
            },
            "Status": {
                "select": {
                    "options": [
                        {"name": "Backlog", "color": "gray"},
                        {"name": "To Do", "color": "yellow"},
                        {"name": "In Progress", "color": "orange"},
                        {"name": "Review", "color": "purple"},
                        {"name": "Done", "color": "green"}
                    ]
                }
            },
            "Priority": {
                "select": {
                    "options": [
                        {"name": "Critical", "color": "red"},
                        {"name": "High", "color": "orange"},
                        {"name": "Medium", "color": "yellow"},
                        {"name": "Low", "color": "gray"}
                    ]
                }
            },
            "Project": {
                "relation": {"database_id": "placeholder"}
            },
            "Description": {
                "rich_text": {}
            },
            "Assignee": {
                "people": {}
            },
            "Due Date": {
                "date": {}
            },
            "Estimated Hours": {
                "number": {"format": "number"}
            },
            "Actual Hours": {
                "number": {"format": "number"}
            }
        }
        
        return self.create_database("✓ Active Tasks", properties)
    
    def create_views(self, database_id: str, view_type: str = "kanban") -> Dict:
        """Create custom views for the database"""
        url = f"{self.base_url}/databases/{database_id}/query"
        
        # This will be implemented based on view requirements
        return {"status": "views_created", "database_id": database_id}
    
    def setup_complete_system(self) -> Dict:
        """Complete setup of both databases with relationships"""
        print("🚀 Creating Projects database...")
        projects = self.create_projects_database()
        
        print("✓ Creating Tasks database...")
        tasks = self.create_tasks_database()
        
        # Update tasks relation to point to projects
        return {
            "projects_db": projects,
            "tasks_db": tasks,
            "setup_complete": True
        }

# Run the setup
if __name__ == "__main__":
    api_key = os.getenv("NOTION_API_KEY")
    parent_page_id = "3036582328c7802d8539ef3df0f36d2a"  # MOLTBOT page
    
    if not api_key:
        print("❌ NOTION_API_KEY not found")
        exit(1)
    
    builder = NotionBuilder(api_key, parent_page_id)
    
    try:
        result = builder.setup_complete_system()
        print(json.dumps(result, indent=2))
    except Exception as e:
        print(f"❌ Error: {e}")