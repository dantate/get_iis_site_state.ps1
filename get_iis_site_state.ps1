<#
Daniel Tate
2022-06-07
Quick and dirty powershell script to get status of website in IIS

Invocation: 

iis_site_status.ps1 sitename

.#>

[CmdletBinding()]
Param(
  [Parameter(Mandatory=$True,Position=1)]
   [string]$website
   )


$status=get-websitestate $website
$ahstatus=Get-WebAppPoolState $website

$svalue=$status.value
$ahsvalue=$ahstatus.value

  if (($svalue -eq "Started") -and ($ahsvalue -eq "Started" )){
    $res_string='OK: ' + $website + ' ' + $status.value
	$exit_code = "0"
   
  }
  elseif ($svalue -eq $null) {
	$res_string="UNKNOWN:  $website Status Unknwon"
    $exit_code = "3"
  }
  else
  {	
 
	$res_string='CRITICAL: '+ $website + ' ' + $status.value
	$exit_code = "2"
  }
  


Write-host $res_string
exit $exit_code
