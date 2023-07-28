@ECHO OFF
:: This script will launch the Windows Registry Editor showing the subkeys under
:: FEATURE_BROWSER_EMULATION; it will not modify the registry beside changing
:: the value of the last key viewed by the Registry Editor, which is the only
:: way to force it to open at a specific registry path.

SET "_mykey=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION"
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /V "LastKey" /D "%_mykey%" /F
START /B regedit

:: *****************************************************************************
:: *    DON'T MODIFY THE REGISTRY UNLESS YOU REALLY KNOW WHAT YOU'RE DOING!    *
:: * ------------------------------------------------------------------------- *
:: * Playing around with the registry could degrade the system, or even damage *
:: * your MS Windows installation beyond repair. You've been warned.           *
:: *****************************************************************************

:: Once Registry Editor has launched, you can add the FEATURE_BROWSER_EMULATION
:: path to your Favorites from the menu "Favorites > Add to Favorites...", so
:: that you'll be able to quickly access it in the future without having to use
:: this script.

:: All the FEATURE_BROWSER_EMULATION keys are names of programs requesting the
:: WebBrowser Control to emulate a specific Internet Explorer version when
:: rendering HTML contents. For more info, see:
::    https://weblog.west-wind.com/posts/2011/May/21/Web-Browser-Control-Specifying-the-IE-Version
::    https://learn.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/general-info/ee330730(v=vs.85)#browser-emulation
