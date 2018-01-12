[CmdletBinding()]       
param
(
    [Parameter(Mandatory = $true)]
    [string] $shareStorageAccount,

    [Parameter(Mandatory = $true)]
    [string] $shareSecretKey
)

##############################
# Main function

if ($PSVersionTable.PSVersion.Major -lt 3)
{
    Write-Error "The current version of PowerShell is $($PSVersionTable.PSVersion.Major). Prior to running this artifact, ensure you have PowerShell 3 or higher installed."
}

else
{
    $acctKey = ConvertTo-SecureString $shareSecretKey -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential -ArgumentList "Azure\$shareStorageAccount", $acctKey
    New-PSDrive -Name V -PSProvider FileSystem -Root "\\$shareStorageAccount.file.core.windows.net\demoshare" -Credential $credential -Persist
}
