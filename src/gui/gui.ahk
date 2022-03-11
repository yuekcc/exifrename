; a simple gui for exifrename.py
; this script was tested on WINXP

; �����Զ���ǰ׺���
Enable_Prefix := false

; GUI CONTROL SETTINGS
; ����GUI�ؼ�
Gui, Add, Text, x16 y17 w90 h20 , ѡ��Ŀ¼��
Gui, Add, Button, x296 y47 w100 h30 gSelectFloder, ���
Gui, Add, Edit, x16 y47 w270 h30 vCtrlEdit_PicFloder
Gui, Add, GroupBox, x16 y87 w380 h80 +Left, ����
Gui, Add, CheckBox, x26 y117 w100 h30 gSettingPrefix, �Զ���ǰ׺
Gui, Add, Edit, x136 y117 w250 h30 vCtrlEdit_Prefix
Gui, Add, Button, x296 y177 w100 h30 gGuiClose, �˳�
Gui, Add, Button, x186 y177 w100 h30 gDoRename, ��ʼ

; ���ÿؼ���ʼ״̬
GuiControl, Disable, CtrlEdit_Prefix

; ��ʾ������
Gui, Show, x341 y145 h227 w420, Exif Renamer
Return

; program exit
; �˳�����
GuiClose:
	ExitApp

; select folder for photos
; ѡ����ƬĿ¼
SelectFloder:
	FileSelectFolder, PicFloder
	if (PicFloder = "")
		return
	GuiControl, , CtrlEdit_PicFloder, %PicFloder%
	return

; �����ļ���ǰ׺
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
; ����exifrename.py�ű�
DoRename:
	if (Enable_Prefix)
	{
		GuiControlGet, Prefix, , CtrlEdit_Prefix
		if (Prefix = "")
		{
			Msgbox, ������ǰ׺
			return
		}
		Argv_Prefix = --prefix=%Prefix%
	}
	
	GuiControlGet, PicFloder, , CtrlEdit_PicFloder
	if (PicFloder = "")
	{
		MsgBox, ��ѡ��Ŀ¼
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
