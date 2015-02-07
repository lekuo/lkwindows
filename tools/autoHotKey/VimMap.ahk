; vim.exe must be in the %path% variable or in the same directory as vimedit.exe
; http://www.autohotkey.com/board/topic/78526-edit-everywhere-with-vim/
;On peut mettre la fenetre de vim blanche si on clique dans le coin gauche de la fenetre de vim.exe et on fait proprietes, dans les proprietes on peut changer les couleur et la font "lucida console 14"

#SingleInstance force

usage = 
(
    usage:
    win-; or win-alt-; : Insert text at current position in control or document using vim
    win-i : Edit selected text in document or control using vim (current line if no selection)
    win-alt-i : Edit all text in document or control using vim
    win-o : View selected text in document or control using vim (current line if no selection)
    win-alt-o : View all text in document or control using vim
    win-u or win-alt-u : Launch vim editor
    win-h : Move left 
    win-j : Move down 
    win-k : Move up 
    win-l : Move right
    win-alt-h : Select text leftward
    win-alt-j : Select text downward
    win-alt-k : Select text upward
    win-alt-l : Select text rightward
)
msgbox ,, vimedit, %usage%

Hotkey, #;, Insert
Hotkey, #!;, Insert
Hotkey, #i, EditSelect
Hotkey, #!i, EditAll
Hotkey, #o, ViewSelect
Hotkey, #!o, ViewAll

Hotkey, #!h, SelectLeft
Hotkey, #!j, SelectDown
Hotkey, #!k, SelectUp
Hotkey, #!l, SelectRight

Hotkey, #h, Left
Hotkey, #j, Down
Hotkey, #k, up
Hotkey, #l, Right

; Les hotkeys run doivent etre apres les hotkeys qui appelle des fonctions sinon ca marche pas
#u::Run, vim.exe
#!u::Run, vim.exe

return

Insert:
    Clipboard =
    winId := WinExist("A")
    fileName := "c:\i" . A_YYYY . A_MM . A_DD . A_Hour . A_Min . A_Sec . A_MSec
    FileDelete, %fileName% 
    runwait, vim.exe %fileName%, c:\
    FileRead, contents, %fileName% 
    StringRight, ending, contents, 2
    if ending = `r`n
        StringTrimRight, contents, contents, 2 ; remove last crlf from clipboard
    Clipboard := contents 
    WinActivate ahk_id %winId% 
    Send +{ins}
    contents = 
    FileDelete, %fileName%
return

EditAll:
    Clipboard =
    winId := WinExist("A")
    Send ^{home}
    Send ^+{end}
    Send ^{ins}
    fileName := "c:\ea" . A_YYYY . A_MM . A_DD . A_Hour . A_Min . A_Sec . A_MSec
    FileDelete, %fileName% 
    FileAppend, %Clipboard%, %fileName%
    runwait, vim.exe %fileName%, c:\
    FileRead, contents, %fileName%
    StringRight, ending, contents, 2
    if ending = `r`n
        StringTrimRight, contents, contents, 2 ; remove last crlf from clipboard
    Clipboard := contents
    WinActivate ahk_id %winId% 
    Send +{ins}
    Send ^{home}
    contents = 
    FileDelete, %fileName%
return

EditSelect:
    winId := WinExist("A")
    Clipboard =
    Send ^{ins}
    ; If no text is selected then select the current line
    if Clipboard = 
    {
        Send {home}
        Send +{end}
        Send ^{ins}
    }
    fileName := "c:\es" . A_YYYY . A_MM . A_DD . A_Hour . A_Min . A_Sec . A_MSec
    FileDelete, %fileName%
    FileAppend, %Clipboard%, %fileName%
    runwait, vim.exe %fileName%, c:\
    FileRead, contents, %fileName%
    StringRight, ending, contents, 2
    if ending = `r`n
        StringTrimRight, contents, contents, 2 ; remove last crlf from clipboard
    Clipboard := contents 
    WinActivate ahk_id %winId% 
    Send +{ins}
    contents = 
    FileDelete, %fileName%
return

ViewAll: 
    Clipboard =
    Send ^{home}
    Send ^+{end}
    Send ^{ins}
    fileName := "c:\va" . A_YYYY . A_MM . A_DD . A_Hour . A_Min . A_Sec . A_MSec
    FileDelete, %fileName%
    FileAppend, %Clipboard%, %fileName%
    runwait, vim.exe %fileName%, c:\
    FileDelete, %fileName%
return

ViewSelect:
    Clipboard =
    Send ^{ins}
    ; If no text is selected then select the current line
    if Clipboard = 
    {
        Send {home}
        Send +{end}
        Send ^{ins}
    }
    fileName := "c:\vs" . A_YYYY . A_MM . A_DD . A_Hour . A_Min . A_Sec . A_MSec
    FileDelete, %fileName%
    FileAppend, %Clipboard%, %fileName%
    runwait, vim.exe %fileName%, c:\
    FileDelete, %fileName%
return

Left:
    Send {Left down}
return

Down:
    Send {Down down}
return

Up:
    Send {Up down}
return

Right:
    Send {Right down}
return

SelectLeft:
    Send +{Left}
return

SelectDown:
    Send +{Down}
return

SelectUp:
    Send +{Up}
return

SelectRight:
    Send +{Right}
return
