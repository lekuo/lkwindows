;//HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer    NoWinKeys REG_DWORD 0x00000001 (1)
; array key
#e::Send {Up}
#s::Send {Left}
#d::Send {Down}
#f::Send {Right}

#j::Send {Ins}
#m::Send {Del}
#k::Send {Home}
#,::Send {End}
#l::Send {PgUp}
#.::Send {PgDn}
#;::Send {BS}