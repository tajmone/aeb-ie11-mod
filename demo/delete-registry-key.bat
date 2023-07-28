@ECHO OFF
ECHO This script will delete from the Windows registry the IE11 browser emulation key
ECHO associated with the demo EBook, so that it will revert to the default behavior.
REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION" /v "Demo AEB IE11 Mod.exe"
