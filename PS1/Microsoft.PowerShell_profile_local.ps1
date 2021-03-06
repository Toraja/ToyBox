# <User and machine dependencies>
# <Variables>
Set-Variable -Name toybox        -Value $env:USERPROFILE\toybox
Set-Variable -Name Annex         -Value $toybox\PS1
Set-Variable -Name garage        -Value $env:USERPROFILE\garage
Set-Variable -Name db            -Value $garage\db
Set-Variable -Name ide           -Value $garage\ide
Set-Variable -Name lang          -Value $garage\lang
Set-Variable -Name middle        -Value $garage\middle
Set-Variable -Name tools         -Value $garage\tools
Set-Variable -Name CatalinaHome  -Value $middle\tomcat
Set-Variable -Name MysqlHome     -Value $db\mysql
Set-Variable -Name MongoHome     -Value $db\mongo
Set-Variable -Name EclipceHome   -Value $ide\eclipse
Set-Variable -Name ArduinoHome   -Value $ide\arduino
Set-Variable -Name PlantumlHome  -Value $tools\plantuml
Set-Variable -Name QBHome        -Value $env:ProgramFiles/qutebrowser
Set-Variable -Name NodejsHome    -Value ${env:ProgramFiles}\nodejs
Set-Variable -Name JavaHome      -Value $lang\java # this is symlink path pointing real java binary
Set-Variable -Name VimHome       -Value $tools\Vim
Set-Variable -Name VimRtp        -Value $VimHome\vim81
Set-Variable -Name NvimHome      -Value $tools\Neovim
Set-Variable -Name NvimRtp       -Value $NvimHome\share\nvim\runtime
$env:NVIM_PYTHON_LOG_FILE = "$NvimHome/log"
Set-Variable -Name vimfiles      -Value $HOME\vimfiles
Set-Variable -Name ftplugin      -Value ${vimfiles}\ftplugin
Set-Variable -Name after         -Value ${vimfiles}\after
Set-Variable -Name aftplugin     -Value ${after}\ftplugin
Set-Variable -Name CygwinHome    -Value C:\cygwin64

# also set to environment variable
&{
	$vars = @(
		'PROFILE', 'toybox', 'Annex', 'garage', 'db', 'ide', 'lang', 'middle', 'tools',
		'CatalinaHome', 'MysqlHome', 'MongoHome', 'EclipceHome',
		'PlantumlHome', 'NodejsHome', 'JavaHome', 'VimHome', 'VimRtp',
		'NvimHome', 'NvimRtp', 'CygwinHome', 'vimfiles', 'ftplugin',
		'after', 'aftplugin'
	)
	foreach ($var in $vars){
		Set-Item -Path "Env:${var}" -Value $(Get-Variable -Name ${var}).Value
	}
}

# Environment Path
if($env:Path -notmatch "$("$env:USERPROFILE\bin" -replace "\\","\\")"){
	$env:Path += ";$env:USERPROFILE\bin"
}
# Java
if($env:Path -notmatch "$("$JavaHome\bin" -replace "\\","\\")"){
	$env:Path += ";$JavaHome\bin"
}
# node/npm
# if($env:Path -notmatch "$("$NodejsHome" -replace "\\","\\")"){
    # $env:Path += ";$NodejsHome"
# }
# PS1/bin
if($env:Path -notmatch "$("$Annex\bin" -replace "\\","\\")"){
    $env:Path += ";$Annex\bin"
}
# vim - required by qutebrowser
if($env:Path -notmatch "$("$VimRtp" -replace "\\","\\")"){
	$env:Path += ";$VimRtp"
}
# external commands
if($env:Path -notmatch "$("$env:USERPROFILE\Documents\WindowsPowerShell\bin" -replace "\\","\\")"){
    $env:Path += ";$env:USERPROFILE\Documents\WindowsPowerShell\bin"
}


# --- Define temp varables ---
# This is self executing anonymous function
&{
    ## example of distionary
    ## @{ "a"="apple"; "b"="banana"; }
    Set-Variable -Name tempVarTable -Value @{
    }

    $varPrefix = "`$"
    $maxVarLength = 0
    $tempVarTable.Keys.GetEnumerator().ForEach({
        if($_.Length -gt $maxVarLength){$maxVarLength = $_.Length + $varPrefix.Length}
    })

    foreach ($entry in $tempVarTable.GetEnumerator()){
        Set-Variable -Name $entry.Key -Value $entry.Value -Scope Global
        $variable = $varPrefix + ${entry}.Key

        "  {0,-$maxVarLength}  =  {1}" -f $variable, $entry.Value
    }
}
