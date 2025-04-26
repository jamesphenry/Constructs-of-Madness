# ================================
# 🧪 new-mad-experiment.ps1
# ================================

# Creates a new experiment in the experiments folder

$experimentName = Read-Host "Enter experiment name"
$experimentFolder = "./experiments/$experimentName"

# Create experiment folder
New-Item -ItemType Directory -Path $experimentFolder -Force

# Create README.md with a basic template
"## 📜 Summary" | Out-File "$experimentFolder/README.md" -Encoding utf8

# Create BaseCode.cex with a placeholder
"// 🧚 BaseCode.cex" | Out-File "$experimentFolder/BaseCode.cex" -Encoding utf8

# Define the content for the Polyglot notebook in JSON format with proper metadata
$ipynbContent = @{
    cells = @(
        @{
            cell_type = "markdown"
            metadata = @{}
            source = @(
                "# $experimentName Experiment",
                "> **Summary:** Experiment description goes here."
            )
        },
        @{
            cell_type = "code"
            metadata = @{}
            source = @(
                "// Your C# code here"
            )
        }
    )
    metadata = @{
        kernelspec = @{
            display_name = ".NET (C#)"
            language = "C#"
            name = ".net-csharp"
        }
        language_info = @{
            name = "csharp"
        }
        polyglot_notebook = @{
            kernelInfo = @{
                defaultKernelName = "csharp"
                items = @(
                    @{
                        name = "csharp"
                        aliases = @()
                    }
                )
            }
        }
    }
    nbformat = 4
    nbformat_minor = 5
}

# Convert the content to JSON and save it as a notebook
$ipynbContent | ConvertTo-Json -Depth 10 | Set-Content -Path "$experimentFolder/$experimentName.ipynb" -Encoding utf8

Write-Host "✅ New experiment '$experimentName' created!" -ForegroundColor Green
