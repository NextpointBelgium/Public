#Target Computername
$Serial = Get-WmiObject Win32_bios | Select-Object -ExpandProperty SerialNumber
$TargetComputername = "WS-$Serial"
$ComputerName = $env:COMPUTERNAME
Write-Log "Current ComputerName '$env:COMPUTERNAME'"
Write-Log "Target ComputerName: '$TargetComputername'"
  
if ($TargetComputername.Length -ge 15) {
   Write-Log "Target ComputerName is longer ($($TargetComputername.Length)) than the allowed length of 15. It will be shorted."
   $TargetComputername = $TargetComputername.substring(0, 15)
   Write-Log "New Target ComputerName: '$TargetComputername' "
}
  
if ($ComputerName -eq $TargetComputername) {
   Write-Log "Computer Name matched! Compliant."
   return "Compliant"
} else {
   Write-Log "Computer Name doesn't match! Non Compliant"
   Rename-Computer $TargetComputername
   Write-Log "Change Computer Name from $($env:COMPUTERNAME) to $TargetComputername"
   Write-Log "Reboot required."
   return "NonCompliant"
}