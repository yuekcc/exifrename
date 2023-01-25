; a simple gui for exifrename.py
; this script was tested on WINXP

; 启动自定义前缀标记
Enable_Prefix := false

; GUI CONTROL SETTINGS
; 创建GUI控件
Gui, Add, Text, x16 y17 w90 h20 , 选择目录：
Gui, Add, Button, x296 y47 w100 h30 gSelectFloder, 浏览
Gui, Add, Edit, x16 y47 w270 h30 vCtrlEdit_PicFloder
Gui, Add, GroupBox, x16 y87 w380 h80 +Left, 设置
Gui, Add, CheckBox, x26 y117 w100 h30 gSettingPrefix, 自定义前缀
Gui, Add, Edit, x136 y117 w250 h30 vCtrlEdit_Prefix
Gui, Add, Button, x296 y177 w100 h30 gGuiClose, 退出
Gui, Add, Button, x186 y177 w100 h30 gDoRename, 开始

; 设置控件初始状态
GuiControl, Disable, CtrlEdit_Prefix

; 显示主窗口
Gui, Show, x341 y145 h227 w420, Exif Renamer
Return

; program exit
; 退出程序
GuiClose:
	ExitApp

; select folder for photos
; 选择照片目录
SelectFloder:
	FileSelectFolder, PicFloder
	if (PicFloder = "")
		return
	GuiControl, , CtrlEdit_PicFloder, %PicFloder%
	return

; 设置文件名前缀
SettingPrefix:
	if (Enable_Prefix)
	{
		Enable_Prefix := false
		GuiControl, , CtrlEdit_Prefix, 
		GuiControl, Disable, CtrlEdit_Prefix
		return
	}
	GuiControl, Enable, CtrlEdit_Prefix
	Enable_Prefix := true
	return
	
; start renaming
; 启动exifrename.py脚本
DoRename:
	if (Enable_Prefix)
	{
		GuiControlGet, Prefix, , CtrlEdit_Prefix
		if (Prefix = "")
		{
			Msgbox, 请输入前缀
			return
		}
		Argv_Prefix = --prefix=%Prefix%
	}
	
	GuiControlGet, PicFloder, , CtrlEdit_PicFloder
	if (PicFloder = "")
	{
		MsgBox, 请选择目录
		return
	}

	;Msgbox, %Argv_Prefix%
	IfExist, exifrename.py
	{
		Run %comspec% /c "exifrename.py %Argv_Prefix% "%PicFloder%""
		return
	}
	Run %comspec% /c "exifrename.exe %Argv_Prefix% "%PicFloder%""
	return
