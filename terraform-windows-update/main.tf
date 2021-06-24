resource "aws_ssm_document" "WindowsUpdates" {
  name          = "AutomaticWindowsUpdate"
  document_type = "Command"
  content = <<DOC
  {
  	"schemaVersion": "2.2",
  	"description": "enable automatic update",
  	"mainSteps": [{
  			"action": "aws:runPowerShellScript",
  			"precondition": {
  				"StringEquals": [
  					"platformType",
  					"Windows"
  				]
  			},
  			"name": "enableAutoUpdate",
  			"inputs": {
  				"runCommand": [
  					"PowerShell.exe Set-ItemProperty -Path 'HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU' -Name NoAutoUpdate -Value 0"
  				]
  			}
  		},
  		{
  			"action": "aws:runPowerShellScript",
  			"precondition": {
  				"StringEquals": [
  					"platformType",
  					"Windows"
  				]
  			},
  			"name": "EnableScheduledUpdate",
  			"inputs": {
  				"runCommand": [
  					"PowerShell.exe Set-ItemProperty -Path 'HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU' -Name AUOptions -Value 4"
  				]
  			}
  		},
  		{
  			"action": "aws:runPowerShellScript",
  			"precondition": {
  				"StringEquals": [
  					"platformType",
  					"Windows"
  				]
  			},
  			"name": "ScheduleInstallDaily",
  			"inputs": {
  				"runCommand": [
  					"PowerShell.exe Set-ItemProperty -Path 'HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU' -Name ScheduledInstallDay -Value 0"
  				]
  			}
  		}
  	]
  }
DOC
}


resource "aws_ssm_association" "WindowsUpdates" {
  name = aws_ssm_document.WindowsUpdates.name
  targets {
    key    = var.key
    values = var.application_tag_value
  }
}
