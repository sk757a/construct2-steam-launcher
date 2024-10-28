switch ($env:PROCESSOR_ARCHITECTURE)
{
    'x86' {
        $dll = "$env:SteamPath\GameOverlayRenderer.dll"
        $exe = 'Construct2-Win32\Construct2.exe'
        break
    }
    'AMD64' {
        $dll = "$env:SteamPath\GameOverlayRenderer64.dll"
        $exe = 'Construct2-Win64\Construct2.exe'
        break
    }
    default {
        exit 1
    }
}

$env:SteamNoOverlayUI = "1"

$aclDeny = Get-Acl $dll
$aclOrig = Get-Acl $dll

$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($env:USERNAME,"ReadAndExecute","Deny")
$aclDeny.SetAccessRule($rule)
Set-Acl $dll $aclDeny

Start-Process $exe

Write-Host 'Wait some time'
Start-Sleep -s 10

Set-Acl $dll $aclOrig
