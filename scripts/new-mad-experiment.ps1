# ================================
# 🧪 new-mad-experiment.ps1
# ================================

# Creates a new experiment in the experiments folder

$experimentName = Read-Host "Enter experiment name"
$experimentFolder = "./experiments/$experimentName"

# Create experiment folder and files
New-Item -ItemType Directory -Path $experimentFolder -Force

"## 📜 Summary" | Out-File "$experimentFolder/README.md" -Encoding utf8
"// 🧚 BaseCode.cex" | Out-File "$experimentFolder/BaseCode.cex" -Encoding utf8
"experimentName" | Out-File "$experimentFolder/$experimentName.ipynb" -Encoding utf8

Write-Host "✅ New experiment $experimentName created!" -ForegroundColor Green
