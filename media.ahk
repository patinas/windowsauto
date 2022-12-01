Home::sendinput {Media_Prev}
End::sendinput {Media_Next}
Pause::sendinput {Media_Play_Pause}
!Numpad0::sendinput {Volume_Mute}
PgUp::sendinput {Volume_Up}
PgDn::sendinput {Volume_Down}
!s::WinMinimize, A
!Q:: ; Windows and Q closes active window
WinGetTitle, Title, A
PostMessage, 0x112, 0xF060,,, %Title%
return

F1::SetTimer, IdleCheck, 500
F2::SetTimer, IdleCheck, Off

IdleCheck:
If(A_TimeIdle<500)
SendMessage,0x112,0xF170,2,,Program Manager
Return
