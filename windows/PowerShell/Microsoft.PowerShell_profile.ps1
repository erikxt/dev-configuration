Import-Module Get-ChildItemColor

$env:PYTHONIOENCODING="utf-8"
# Remove curl alias
If (Test-Path Alias:curl) {Remove-Item Alias:curl}
If (Test-Path Alias:curl) {Remove-Item Alias:curl}
# Remove-Item alias:ls -force
Set-Alias l Get-ChildItemColor -option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope

function GitLogPretty {
  git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all
}

function PrettyLS {
  colorls --light -A
}

function GitStat {git status}

function GoBack {Set-Location ..}

function GetMyIp {curl -L tool.lu/ip}
function UpdateScoop {scoop update; scoop update *}

function UpdateChoco {choco upgrade chocolatey}

Import-Module posh-git
Import-Module oh-my-posh
# $DefaultUser = 'spenc'

# Setup other alias
Set-Alias open Invoke-Item
Set-Alias .. GoBack
Set-Alias glola GitLogPretty
Set-Alias gst GitStat
Set-Alias myip GetMyIp
Set-Alias pls PrettyLS

# Set theme
Set-Theme Sorin

Set-PSReadLineOption -PredictionSource History # 设置预测文本来源为历史记录
 
Set-PSReadlineKeyHandler -Key Tab -Function Complete # 设置 Tab 键补全
Set-PSReadLineKeyHandler -Key "Ctrl+d" -Function MenuComplete # 设置 Ctrl+d 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo # 设置 Ctrl+z 为撤销
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward # 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward # 设置向下键为前向搜索历史纪录