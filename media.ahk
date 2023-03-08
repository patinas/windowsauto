
PgUp::sendinput {Volume_Up}
PgDn::sendinput {Volume_Down}
!s::WinMinimize, A
!Q:: ; Windows and Q closes active window
WinGetTitle, Title, A
PostMessage, 0x112, 0xF060,,, %Title%
return

