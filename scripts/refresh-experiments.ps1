# ==========================
# 🧪 refresh-experiments.ps1
# ==========================

# Refreshes docs/experiments.md based on experiments created

function Refresh-ExperimentsDoc {
    $experimentsPath = "./experiments"
    $outputFile = "./docs/experiments.md"

    $experiments = Get-ChildItem $experimentsPath -Directory | Sort-Object Name

    $lines = @()
    $lines += "# 🧪 Experiments Archive"
    $lines += "---"

    foreach ($exp in $experiments) {
        $lines += "- [$($exp.Name)](../experiments/$($exp.Name)/$($exp.Name).ipynb) — *Experiment Summary here*"
    }

    $lines | Set-Content -Path $outputFile -Encoding utf8

    Write-Host "✅ experiments.md refreshed successfully!" -ForegroundColor Green
}

Refresh-ExperimentsDoc
