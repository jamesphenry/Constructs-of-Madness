# ==========================
# 🧪 reset-lab.ps1
# ==========================

# Function to load variables from the .env file
function Load-DotEnv {
    $envFile = "./.env"
    if (Test-Path $envFile) {
        Write-Host "✔ .env file found. Loading variables..." -ForegroundColor Green
        $lines = Get-Content $envFile
        foreach ($line in $lines) {
            if ($line -match "^\s*([^#][^=]*)\s*=\s*(.*)") {
                $name = $matches[1].Trim()
                $value = $matches[2].Trim('"')
                [System.Environment]::SetEnvironmentVariable($name, $value, [System.EnvironmentVariableTarget]::Process)
            }
        }
    } else {
        Write-Host "⚠️ .env file not found!" -ForegroundColor Red
    }
}

# Load environment variables from the .env file
Load-DotEnv

# Resets the entire experiments folder, docs, and logs folder
function Reset-Lab {
    Write-Host ""
    Write-Host "🧹 WARNING: This will DELETE ALL experiments, logs, and reset documentation!" -ForegroundColor Red
    Write-Host ""
    
    # Get the RESET_SKIP_CONFIRMATION from the environment
    $skipConfirmation = $env:RESET_SKIP_CONFIRMATION -eq "true"

    if (-not $skipConfirmation) {
        $confirm1 = Read-Host "Are you absolutely sure you want to proceed? (yes/no)"

        if ($confirm1 -ne "yes") {
            Write-Host "❌ Lab reset cancelled." -ForegroundColor Yellow
            exit 0
        }

        $confirm2 = Read-Host "FINAL CONFIRMATION: Type 'I am the Mad Scientist' to proceed"

        if ($confirm2 -ne "I am the Mad Scientist") {
            Write-Host "❌ Lab reset cancelled at final confirmation." -ForegroundColor Yellow
            exit 0
        }
    } else {
        Write-Host "🔓 Skipping final confirmation as requested!" -ForegroundColor Green
    }

    Write-Host ""
    Write-Host "🧹 Deleting experiments..." -ForegroundColor Cyan

    $experimentsPath = "./experiments"

    if (Test-Path $experimentsPath) {
        Write-Host "✔ Found the experiments folder. Now deleting contents..." -ForegroundColor Green

        # Get all items in the experiments folder recursively
        $experimentsItems = Get-ChildItem $experimentsPath -Recurse
        Write-Host "Found $($experimentsItems.Count) items to delete..." -ForegroundColor Yellow

        foreach ($item in $experimentsItems) {
            Write-Host "🧹 Deleting: $($item.FullName)" -ForegroundColor Cyan
            Remove-Item $item.FullName -Force -Recurse
        }

        Write-Host "✅ All experiments removed." -ForegroundColor Green
    }
    else {
        Write-Host "⚠️ No experiments folder found!" -ForegroundColor Red
    }

    Write-Host ""
    Write-Host "🧹 Deleting logs..." -ForegroundColor Cyan

    $logsPath = "./logs"

    if (Test-Path $logsPath) {
        Write-Host "✔ Found the logs folder. Now deleting contents..." -ForegroundColor Green

        # Get all items in the logs folder recursively
        $logsItems = Get-ChildItem $logsPath -Recurse
        Write-Host "Found $($logsItems.Count) items to delete..." -ForegroundColor Yellow

        foreach ($item in $logsItems) {
            Write-Host "🧹 Deleting: $($item.FullName)" -ForegroundColor Cyan
            Remove-Item $item.FullName -Force -Recurse
        }

        Write-Host "✅ All logs removed." -ForegroundColor Green
    }
    else {
        Write-Host "⚠️ No logs folder found!" -ForegroundColor Yellow
    }

    Write-Host ""
    Write-Host "🧹 Resetting docs/experiments.md..." -ForegroundColor Cyan

    $experimentsDocPath = "./docs/experiments.md"
    
    if (Test-Path $experimentsDocPath) {
        Write-Host "✔ Found experiments.md file. Resetting content..." -ForegroundColor Green
    } else {
        Write-Host "⚠️ No experiments.md file found. Creating new one..." -ForegroundColor Yellow
    }

    # Create or reset the experiments.md file
    @"
# 🧪 Experiments Archive

---

> No experiments yet. Awaiting the next glorious surge of madness.

---
"@ | Set-Content $experimentsDocPath -Encoding utf8

    Write-Host "✅ experiments.md reset." -ForegroundColor Green

    # (Optional) Add a MAD-TIME log entry
    $timestamp = (Get-Date -Format "HHmmss")
    $logline = "$([char]0x26A1) MAD-TIME: $timestamp - Lab reset performed."
    Add-Content -Path "./logs/experiment-log.txt" -Value $logline

    Write-Host ""
    Write-Host "🌟 Mad Lab has been reset to a clean slate!" -ForegroundColor Green
}

Reset-Lab
