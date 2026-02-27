# Notion Database Creation Script for MOLTBOT Workspace

$headers = @{
    "Authorization" = "Bearer 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"
    "Content-Type" = "application/json"
    "Notion-Version" = "2022-06-28"
}

# Create Projects Database
$projectsDatabaseBody = @{
    parent = @{
        page_id = "3036582328c7802d8539ef3df0f36d2a"
    }
    title = @(
        @{
            type = "text"
            text = @{ content = "🔬 MOLTBOT Projects" }
        }
    )
    properties = @{
        "Name" = @{
            title = @()
        }
        "Status" = @{
            select = @{
                options = @(
                    @{ name = "📋 Not Started"; color = "gray" }
                    @{ name = "🎯 Planning"; color = "blue" }
                    @{ name = "⚡ In Progress"; color = "yellow" }
                    @{ name = "🔍 Review"; color = "purple" }
                    @{ name = "✅ Completed"; color = "green" }
                    @{ name = "⏸️ On Hold"; color = "orange" }
                    @{ name = "🗑️ Cancelled"; color = "red" }
                )
            }
        }
        "Type" = @{
            select = @{
                options = @(
                    @{ name = "Research"; color = "purple" }
                    @{ name = "Development"; color = "blue" }
                    @{ name = "Marketing"; color = "green" }
                    @{ name = "Operations"; color = "orange" }
                    @{ name = "Strategy"; color = "pink" }
                    @{ name = "Personal"; color = "brown" }
                )
            }
        }
        "Priority" = @{
            select = @{
                options = @(
                    @{ name = "Critical"; color = "red" }
                    @{ name = "High"; color = "orange" }
                    @{ name = "Medium"; color = "yellow" }
                    @{ name = "Low"; color = "gray" }
                )
            }
        }
        "Due Date" = @{
            date = @{
            }
        }
        "Progress" = @{
            number = @{
                format = "percent"
            }
        }
        "Owner" = @{
            people = @{
            }
        }
        "Description" = @{
            rich_text = @{
            }
        }
    }
} | ConvertTo-Json -Depth 10

Write-Host "Creating Projects Database..."
$projectsResponse = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases" -Method Post -Headers $headers -Body $projectsDatabaseBody
$projectsId = $projectsResponse.id
Write-Host "✅ Projects Database created with ID: $projectsId"

# Create Tasks Database
$tasksDatabaseBody = @{
    parent = @{
        page_id = "3036582328c7802d8539ef3df0f36d2a"
    }
    title = @(
        @{
            type = "text"
            text = @{ content = "📝 MOLTBOT Tasks" }
        }
    )
    properties = @{
        "Name" = @{
            title = @()
        }
        "Project" = @{
            relation = @{
                database_id = $projectsId
                single_property = @{
                }
            }
        }
        "Status" = @{
            select = @{
                options = @(
                    @{ name = "Backlog"; color = "gray" }
                    @{ name = "To Do"; color = "blue" }
                    @{ name = "In Progress"; color = "yellow" }
                    @{ name = "In Review"; color = "purple" }
                    @{ name = "Testing"; color = "orange" }
                    @{ name = "Done"; color = "green" }
                )
            }
        }
        "Priority" = @{
            select = @{
                options = @(
                    @{ name = "Critical"; color = "red" }
                    @{ name = "High"; color = "orange" }
                    @{ name = "Medium"; color = "yellow" }
                    @{ name = "Low"; color = "gray" }
                )
            }
        }
        "Type" = @{
            select = @{
                options = @(
                    @{ name = "Feature"; color = "blue" }
                    @{ name = "Bug Fix"; color = "red" }
                    @{ name = "Research"; color = "purple" }
                    @{ name = "Documentation"; color = "green" }
                    @{ name = "Design"; color = "pink" }
                    @{ name = "Testing"; color = "orange" }
                    @{ name = "Meeting"; color = "brown" }
                )
            }
        }
        "Due Date" = @{
            date = @{
            }
        }
        "Assigned" = @{
            people = @{
            }
        }
        "Estimated Hours" = @{
            number = @{
                format = "number"
            }
        }
        "Actual Hours" = @{
            number = @{
                format = "number"
            }
        }
        "Notes" = @{
            rich_text = @{
            }
        }
        "URL" = @{
            url = @{
            }
        }
    }
} | ConvertTo-Json -Depth 10

Write-Host "Creating Tasks Database..."
$tasksResponse = Invoke-RestMethod -Uri "https://api.notion.com/v1/databases" -Method Post -Headers $headers -Body $tasksDatabaseBody
$tasksId = $tasksResponse.id
Write-Host "✅ Tasks Database created with ID: $tasksId"

# Output results in format for main agent
Write-Host ""
Write-Host "=== MOLTBOT NOTION WORKSPACE SUMMARY ==="
Write-Host "Page ID: 3036582328c7802d8539ef3df0f36d2a"
Write-Host "Projects Database ID: $projectsId"
Write-Host "Tasks Database ID: $tasksId"
Write-Host "Both databases are now available under: MOLTBOT/MOLTBOT"