# HandyPowershell
Handy items for working with Powershell managing in a windows environment.
Run a command remotely on a target computer

Invoke-Command -computername ww-bt544h2 -ScriptBlock {POWERSHELL COMMAND GOES HERE}

#Getting Average CPU Load of CPU

Get-WmiObject win32_processor | Measure-Object -property LoadPercentage -Average | Select Average

#Get Applications using most CPU over time

Get-WmiObject Win32_PerfFormattedData_PerfProc_Process | `

where-object{ $_.Name -ne "_Total" -and $_.Name -ne "Idle"} | `
Sort-Object PercentProcessorTime -Descending | `
select -First 5 | `
Format-Table Name,IDProcess,PercentProcessorTime -AutoSize

#Uninstall Command for any application

$Ver = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall |   Get-ItemProperty |   Where-Object {$_.DisplayName -match "APPLICATIONNAME" } |   Select-Object -Property DisplayName, UninstallString   $ver  

Get Last 10 reboot times and reasons

Get-EventLog -LogName system -Source user32  -Newest 10 | Select Timegenerated,message -Unique | ft -Wrap

#Get all Application Errors to troubleshoot crashing


$SysEvent = Get-Eventlog -Logname system -Newest 2000 
$SysError = $SysEvent | Where {$_.entryType -Match "Error"}
$SysError | Sort-Object EventID |
Format-Table EventID, Source, TimeWritten, Message -auto

#Get installed Windows Updates, time

Get-Hotfix
