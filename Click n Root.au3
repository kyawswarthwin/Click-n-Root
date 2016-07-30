#NoTrayIcon
#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Resource\Icon.ico
#AutoIt3Wrapper_Outfile=Release\Click 'n' Root.exe
#AutoIt3Wrapper_Res_Description=Click 'n' Root
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright © 2013 Kyaw Swar Thwin
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf=1 /sv=1
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Misc.au3>
#include "Include\Busy.au3"
#include "Include\Android.au3"

Global Const $sAppName = "Click 'n' Root"
Global Const $sAppVersion = "1.0"
Global Const $sAppPublisher = "Kyaw Swar Thwin"

Global $sTitle = $sAppName

_Singleton($sAppName & " v" & $sAppVersion)

If Not _Android_IsDeviceOnline() Then
	MsgBox(16, $sTitle, "Error: Device Not Found!")
Else
	If _Android_IsDeviceRooted() Then
		MsgBox(64, $sTitle, "Device Is Already Rooted!")
		Exit
	EndIf
	_Busy_Create("Exploiting...", $BUSY_TOPMOST)
	Run(@ScriptDir & "\exploits\Impactor.exe", "", @SW_HIDE)
	WinWait("Cydia Impactor")
	ControlClick("Cydia Impactor", "", "Button1")
	Do
		Sleep(100)
	Until ControlCommand("Cydia Impactor", "", "Button1", "IsEnabled", "")
	ProcessClose("Impactor.exe")
	If Not _Android_IsDeviceRooted() Then
		_Busy_Close()
		MsgBox(16, $sTitle, "Error: Device Can Not Be Rooted!")
	Else
		_Busy_Update("Rooting...")
		_Android_Shell("mkdir /data/local/tmp")
		_Android_ShellAsRoot("rm -R /data/local/tmp/*")
		_Android_Push(@ScriptDir & "\dependencies\busybox", "/data/local/tmp")
		_Android_ShellAsRoot("chmod 755 /data/local/tmp/busybox")
		_Android_Push(@ScriptDir & "\root\su", "/data/local/tmp")
		_Android_Push(@ScriptDir & "\root\Superuser.apk", "/data/local/tmp")
		_Android_Push(@ScriptDir & "\shells\root.sh", "/data/local/tmp")
		_Android_ShellAsRoot("chmod 755 /data/local/tmp/root.sh")
		_Android_ShellAsRoot("sh /data/local/tmp/root.sh")
		_Android_ShellAsRoot("rm -R /data/local/tmp/*")
		_Busy_Update("Rebooting...")
		_Android_Reboot()
		_Busy_Close()
		MsgBox(0, $sTitle, "Device Is Successfully Rooted!")
	EndIf
EndIf
