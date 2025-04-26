# ==========================
# 🧪 reset-lab.ps1
# ==========================

# Resets the entire experiments folder and resets documentation

function Reset-Lab {
    Write-Host ""
    Write-Host "🧹 WARNING: This will DELETE ALL experiments and reset documentation!" -ForegroundColor Red
    Write-Host ""
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

    Write-Host ""
    Write-Host "🧹 Deleting experiments..." -ForegroundColor Cyan

    $experimentsPath = "./experiments"

    if (Test-Path $experimentsPath) {
        Get-ChildItem $experimentsPath -Directory | ForEach-Object {
            Remove-Item $_.FullName -Recurse -Force
        }
        Write-Host "✅ All experiments removed." -ForegroundColor Green
    }
    else {
        Write-Host "⚠️ Experiments folder does not exist." -ForegroundColor Yellow
    }

    Write-Host ""
    Write-Host "🧹 Resetting docs/experiments.md..." -ForegroundColor Cyan

    $experimentsDocPath = "./docs/experiments.md"
    @"
# 🧪 Experiments Archive

---

> No experiments yet. Awaiting the next glorious surge of madness.

---
"@ | Set-Content $experimentsDocPath -Encoding utf8

    Write-Host "✅ experiments.md reset." -ForegroundColor Green

    # (Optional) Add a MAD-TIME log
    $timestamp = (Get-Date -Format "HHmmss")
    $logline = "$([char]0x26A1) MAD-TIME: $timestamp - Lab reset performed."
    Add-Content -Path "./logs/experiment-log.txt" -Value $logline

    Write-Host ""
    Write-Host "🌟 Mad Lab has been reset to a clean slate!" -ForegroundColor Green
}

Reset-Lab
