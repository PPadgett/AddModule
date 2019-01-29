function Add-Module ($ModuleName) {

    # If module is imported say that and do nothing
    if (Get-Module | Where-Object {$_.Name -eq $ModuleName}) {
        write-host "Module $ModuleName is already imported."
    }
    # If module is not imported, but available on disk then import
    elseif (Get-Module -ListAvailable | Where-Object {$_.Name -eq $ModuleName}) { 
        Import-Module $ModuleName -Verbose
    }
    # If module is not imported, not available on disk, but is in online gallery then install and import
    elseif (Find-Module -Name $ModuleName | Where-Object {$_.Name -eq $ModuleName}) {
        Install-Module -Name $ModuleName -Force -Verbose -Scope CurrentUser
        Import-Module $ModuleName -Verbose
    }
    # If module is not imported, not available and not in online gallery then abort
    else {        
        write-host "Module $ModuleName not imported, not available and not in online gallery, exiting."
        EXIT 1
    }
}
 