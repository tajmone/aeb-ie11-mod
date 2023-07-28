#APP_VER$ = "1.0.0" ; 2023-07-28 | PureBasic 6.02 x86

;{******************************************************************************
; *                                                                            *
; *                  Activ E-Book IE-11 Browser Emulation Mod                  *
; *                                                                            *
; *                  https://github.com/tajmone/aeb-ie11-mod                   *
; *                                                                            *
; *                    (c) by Tristano Ajmone, MIT License                     *
; *                                                                            *
; ******************************************************************************
; To enable Internet Explorer 11 emulation in your EBooks:
;
; (1) Add "aeb-ie11-mod.exe" to your HTML source folder.
; (2) In your Activ E-Book project go to "Add-Ins > Event Handlers > On Start"
;     and paste the following string (as is, verbatim):
;
;       {ebook}\aeb-ie11-mod.exe "{exename}" "{title}"
;
; To suppress the pop-up dialog about the EBook needing to be restarted, add the
; "/Q" (quiet) switch after the "On Start" menu string:
;
;       {ebook}\aeb-ie11-mod.exe "{exename}" "{title}" /Q
;
; To show debugging info about the parameters AEB IE11 Mod is receiving (useful
; to solve problem), add the "/V" (verbose) switch instead:
;
;       {ebook}\aeb-ie11-mod.exe "{exename}" "{title}" /V
; ------------------------------------------------------------------------------
; For more info on Web Browser Control emulation modes:
; https://weblog.west-wind.com/posts/2011/May/21/Web-Browser-Control-Specifying-the-IE-Version
; https://msdn.microsoft.com/en-us/library/ee330730(v=vs.85).aspx
; ------------------------------------------------------------------------------
;}
CompilerIf #PB_Compiler_Processor <> #PB_Processor_x86
  CompilerError "Use the 32-bit compiler!"
CompilerEndIf

Declare EBookRestart()
Select CountProgramParameters()
  Case 0
    MessageRequester("AEB IE11 Mod version " + #APP_VER$,
                     ~"Activ E-Book Internet Explorer 11 browser emulation Mod.\n\n" +
                     ~"Copyright © by Tristano Ajmone, 2023. MIT License.\n\n" +
                     "https://github.com/tajmone/aeb-ie11-mod", #PB_MessageRequester_Info)
    End
  Case 1
    MessageRequester("AEB IE11 Mod Error!",
                     ~"You must invoke \"aeb-ie11-mod.exe\" with at least two " +
                     ~"parameters from Add-Ins > On Start:\n\n" +
                     ~"{ebook}\\aeb-ie11-mod.exe \"{exename}\" \"{title}\"",
                     #PB_MessageRequester_Error)
    End 1
  Default
    EBookFullPath$ = ProgramParameter()           ; EBook executable full qualified path
    EBookFilename$ = GetFilePart(EBookFullPath$)  ; Strips the path part and keeps filename.
    EBookTitle$ = ProgramParameter()              ; EBook Window Title (required to close EBook)
    mod_switch.s = UCase(ProgramParameter())      ; Optional AEB IE11 Mod behavior parameter:
    If mod_switch = "/Q"                          ;   /Q  --> Quiet mode
      quiet_mode = #True
    ElseIf  mod_switch = "/V"                     ;   /V  --> Verbose mode (debug info)
      MessageRequester("AEB IE11 Mod Info",
                       ~"E-Book file path: \"" + EBookFullPath$ +
                       ~"\"\nE-Book filename: \"" + EBookFilename$ +
                       ~"\"\nE-Book title: \""+ EBookTitle$ + ~"\"")
    EndIf
EndSelect

; ==============================================================================
;                    Browser Emulation Registry Key Settings
; ==============================================================================
; HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION

#SubKey$ = "SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION"
#IE_Mode = 11001  ; Internet Explorer 11.
                  ; Webpages are displayed in IE11 edge mode, regardless of the declared !DOCTYPE directive.
                  ; Failing to declare a !DOCTYPE directive causes the page to load in Quirks.

Define.s keyName, dwLabel, statusMsg, keyResult.i
Define.l dwValue, dwValueCheck, bufferSize

keyName = #SubKey$
dwLabel = EBookFilename$
dwValue = #IE_Mode
bufferSize = SizeOf(Long)

If RegOpenKeyEx_(#HKEY_CURRENT_USER, keyName, 0, #KEY_ALL_ACCESS, @keyResult) = #ERROR_SUCCESS
  If keyResult And RegQueryValueEx_(keyResult, dwLabel, 0, 0, @dwValueCheck, @bufferSize) = #ERROR_SUCCESS
    If dwValueCheck = dwValue
      ; Browser Emulation is already set correctly for this EBook
      RegCloseKey_(keyResult)
    Else
      ; Browser Emulation is set to a different value for this EBook, fix it
      If RegSetValueEx_(keyResult, @dwLabel, 0, #REG_DWORD, @dwValue, SizeOf(Long)) = #ERROR_SUCCESS
        RegCloseKey_(keyResult)
        EBookRestart()
      EndIf
    EndIf
  Else
    ; No Browser Emulation key for this EBook, create it from scratch
    If RegSetValueEx_(keyResult, @dwLabel, 0, #REG_DWORD, @dwValue, SizeOf(Long)) = #ERROR_SUCCESS
      EBookRestart()
    EndIf
  EndIf
Else
  ; No FEATURE_BROWSER_EMULATION key found, create it and set Browser Emulation for this EBook
  If RegCreateKey_(#HKEY_CURRENT_USER, keyName, @keyResult) = #ERROR_SUCCESS
    If RegSetValueEx_(keyResult, @dwLabel, 0, #REG_DWORD, @dwValue, SizeOf(Long)) = #ERROR_SUCCESS
    EndIf
  EndIf
EndIf

End

Procedure EBookRestart()
  Shared EBookTitle$, EBookFullPath$, quiet_mode
  ; Find EBook handle using its Window title (= EBook title) the terminate its process...
  iHandle = FindWindow_("Activ E-Book Class", EBookTitle$)
  If iHandle
    SendMessage_(iHandle, #WM_SYSCOMMAND, #SC_CLOSE, 0)
    If Not quiet_mode
      MessageRequester("E-Book Configuration Completed",
                       "The E-Book will be restarted for its initial configuration to become effective.",
                       #PB_MessageRequester_Info)
    EndIf
  Else
    MessageRequester("E-BOOK ERROR!",
                     ~"AEB IE11 Mod was unable to find the E-Book window handler.\n\n" +
                     "Please, close and restart the E-Book manually.", #PB_MessageRequester_Error)
    End 1
  EndIf
  ; Restart the EBook
  If Not RunProgram(EBookFullPath$)
    MessageRequester("E-BOOK ERROR!",
                     ~"AEB IE11 Mod was unable to restart the E-Book.\n\n" +
                     "Please, restart the E-Book manually.", #PB_MessageRequester_Error)
    End 1
  EndIf
EndProcedure
