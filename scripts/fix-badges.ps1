# ==========================
# 🧪 fix-badges.ps1
# ==========================

# Fixes README.md badge links based on local Git remote URL

function Fix-ReadmeBadges {
    $readmePath = "./README.md"
    $remoteUrl = git config --get remote.origin.url

    if ($remoteUrl -match "github.com[:/](.*?)/(.*?)(\.git)?$") {
        $githubUser = $matches[1]
        $repoName = $matches[2]
    }

    $content = Get-Content $readmePath -Raw
    $content = $content -replace "yourname", $githubUser
    $content = $content -replace "glowing-giggle", $repoName
    Set-Content -Path $readmePath -Value $content -Encoding utf8

    Write-Host "✅ README.md badges and links updated successfully!" -ForegroundColor Green
}

Fix-ReadmeBadges
