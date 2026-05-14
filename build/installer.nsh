!macro customHeader
  !include "MUI2.nsh"
  !include "nsDialogs.nsh"
  Var StartOnBootCheckbox
  Var StartOnBoot

  Function StartOnBootPage
    nsDialogs::Create 1018
    Pop $0
    ${If} $0 == error
      Abort
    ${EndIf}

    ${NSD_CreateLabel} 0 0 100% 18u "Tâches supplémentaires"
    ${NSD_CreateCheckbox} 0 24u 100% 12u "Lancer Velkora Client au démarrage de Windows"
    Pop $StartOnBootCheckbox
    ${NSD_SetState} $StartOnBootCheckbox ${BST_UNCHECKED}

    nsDialogs::Show
  FunctionEnd

  Function StartOnBootPageLeave
    ${NSD_GetState} $StartOnBootCheckbox $StartOnBoot
  FunctionEnd
!macroend

!macro customInstall
  ${If} $StartOnBoot == ${BST_CHECKED}
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Run" "Velkora Client" "$INSTDIR\velkora client.exe"
  ${Else}
    DeleteRegValue HKCU "Software\Microsoft\Windows\CurrentVersion\Run" "Velkora Client"
  ${EndIf}
!macroend

!macro customUnInstall
  DeleteRegValue HKCU "Software\\Microsoft\\Windows\\CurrentVersion\\Run" "Velkora Client"
!macroend

; Insertion de la page personnalisée avant la page de fin
Page custom StartOnBootPage StartOnBootPageLeave
