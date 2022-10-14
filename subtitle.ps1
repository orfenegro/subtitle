<#
.SYNOPSIS
    ascsi to utf convertor
.DESCRIPTION
    This function lets you convert all ascsi files to utf under the choosen folder and subfolders
.NOTES
    This Script works both in linux and windows
.LINK
    https://farukdurusoy.com/subtitle-powershell.html
.EXAMPLE
    subtitle -url yoururlhere
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
.EXAMPLE
    ikinci example buraya yazılacak
.PARAMETER dir
    değiştirme işleminin uygulanacağı directory
#>

# Get-Content -Path $Path -Raw
#
# [System.IO.File]::ReadAllLines( ( Resolve-Path $Path ) )
# [System.IO.File]::ReadAllText( ( Resolve-Path $Path ) )

<#
try
{
    $stream = [System.IO.StreamWriter]::new( $Path )
    $data | ForEach-Object{ $stream.WriteLine( $_ ) }
}
finally
{
    $stream.close()
}
#>
function Get-Utf {
    [CmdletBinding()]
    param (
    [Parameter(
        Position = 0,
        Mandatory = $true
    )]
    [string]$dir,
    [Parameter(
        Position = 1,
        Mandatory = $true
    )]
    [string]$filename
    )
    Write-Host $dir"\"$filename
}

$dir = "C:\Logs"
try {
    $rawFileInfo = Get-ChildItem $dir -Recurse
}
catch {
    {1:<#Klasöre erişilemedi#>}
}
$fileCount = 0
$names =""
foreach ($item in $rawFileInfo) {
    if ($item.Name -match "\.(srt|txt|sub)$") {
        # this is a folder/directory
        $fileCount++
        Get-Utf -dir $dir -filename $item.Name
    }
    else {
        # this is a file, because it is not a PSIsContainer
        # $fileCount++
        # $totalSize += $item.Length
    }
}


try {
    if (Test-Path -Path $dir) {
        Get-ChildItem -Path $dir -Recurse | Where-Object {$_.DisplayName -match "\.(srt|txt|sub)$"} | Select-Object -Property Name | Get-Utf -dir $dir -filename 
    }
}
catch {
    throw
}