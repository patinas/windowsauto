$Home::
Run, explorer.exe
Return


$End::
Run, "C:\Users\apat0008\OneDrive - Region Hovedstaden\Work\Time Management\Flexskema_2023.xlsx"
Return

$PgUp::
Run, chrome.exe
Return



!s::WinMinimize, A


!q::
WinClose, A
Return

$PgDn::
IfWinExist ahk_class Chrome_WidgetWin_1
{
    WinActivate
    Send ^w
}
Return

