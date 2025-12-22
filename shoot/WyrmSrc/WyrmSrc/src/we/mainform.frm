VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.1#0"; "COMDLG32.OCX"
Begin VB.MDIForm MainForm 
   BackColor       =   &H8000000C&
   Caption         =   "Wyrm Editor"
   ClientHeight    =   6600
   ClientLeft      =   2100
   ClientTop       =   1305
   ClientWidth     =   8340
   Icon            =   "MainForm.frx":0000
   LinkTopic       =   "MDIForm1"
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   3600
      Top             =   120
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327680
      CancelError     =   -1  'True
   End
   Begin VB.Menu MenuFile 
      Caption         =   "File"
      NegotiatePosition=   1  'Left
      Begin VB.Menu MenuNew 
         Caption         =   "New..."
         Begin VB.Menu MenuNewRC 
            Caption         =   "RC File"
         End
         Begin VB.Menu MenuNewClass 
            Caption         =   "Class File"
         End
         Begin VB.Menu MenuNewRWS 
            Caption         =   "RWS File"
         End
      End
      Begin VB.Menu MenuOpen 
         Caption         =   "Open..."
         Begin VB.Menu MenuOpenRC 
            Caption         =   "RC File"
         End
         Begin VB.Menu MenuOpenClass 
            Caption         =   "Class File"
         End
         Begin VB.Menu MenuOpenRWS 
            Caption         =   "RWS File"
         End
      End
      Begin VB.Menu MenuSave 
         Caption         =   "Save All"
      End
      Begin VB.Menu MenuSaveAs 
         Caption         =   "Save All As..."
      End
      Begin VB.Menu MenuClose 
         Caption         =   "Close All"
      End
      Begin VB.Menu MenuExit 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu MenuPreferences 
      Caption         =   "Preferences"
      NegotiatePosition=   1  'Left
      Begin VB.Menu MenuItemlist 
         Caption         =   "Choose Itemlist.txt..."
      End
      Begin VB.Menu MenuModList 
         Caption         =   "Choose Modlist.txt..."
      End
   End
   Begin VB.Menu MenuRC 
      Caption         =   "RC"
      Enabled         =   0   'False
      NegotiatePosition=   2  'Middle
      Begin VB.Menu MenuOpenRC2 
         Caption         =   "Open"
      End
      Begin VB.Menu MenuSaveRC 
         Caption         =   "Save"
      End
      Begin VB.Menu MenuSaveAsRC 
         Caption         =   "Save As..."
      End
      Begin VB.Menu MenuCloseRC 
         Caption         =   "Close"
      End
   End
   Begin VB.Menu MenuClass 
      Caption         =   "Class"
      Enabled         =   0   'False
      NegotiatePosition=   2  'Middle
      Begin VB.Menu MenuOpenClass2 
         Caption         =   "Open..."
      End
      Begin VB.Menu MenuSaveClass 
         Caption         =   "Save"
      End
      Begin VB.Menu MenuSaveAsClass 
         Caption         =   "Save As..."
      End
      Begin VB.Menu MenuCloseClass 
         Caption         =   "Close"
      End
   End
   Begin VB.Menu MenuRWS 
      Caption         =   "RWS"
      Enabled         =   0   'False
      NegotiatePosition=   2  'Middle
      Begin VB.Menu MenuOpenRWS2 
         Caption         =   "Open..."
      End
      Begin VB.Menu MenuSaveRWS 
         Caption         =   "Save"
      End
      Begin VB.Menu MenuSaveAsRWS 
         Caption         =   "Save As..."
      End
      Begin VB.Menu MenuCloseRWS 
         Caption         =   "Close"
      End
   End
   Begin VB.Menu MenuHelp 
      Caption         =   "Help"
      NegotiatePosition=   3  'Right
      Begin VB.Menu MenuAbout 
         Caption         =   "About..."
      End
   End
End
Attribute VB_Name = "MainForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Items_Load(index As Integer)
    Dim ItemFile As String
    Dim SeparadorTrobat As Boolean
    
    On Error GoTo ErrHandler
    ItemFile = GetSetting("WyrmEditor", "ItemFile", "File", "")
    CommonDialog1.filename = ItemFile
    If ItemFile = "" Or index <> 0 Then
        CommonDialog1.DialogTitle = "Locate your itemlist.txt file"
        CommonDialog1.Filter = "itemlist.txt|itemlist.txt|All (*.*)|*.*"
        CommonDialog1.FilterIndex = 1
        CommonDialog1.Flags = cdlOFNHideReadOnly + cdlOFNFileMustExist
        Rem CommonDialog1.ShowOpen
        OpenCM
        If (CommonDialog1.filename <> "") Then
            ItemFile = CommonDialog1.filename
            SaveSetting "WyrmEditor", "ItemFile", "File", ItemFile
        End If
        MainForm.Show
    End If
    
    If ItemFile <> "" Then
        NumItems = 0
        NumWeapons = 0
        SeparadorTrobat = 0
        Id_ClassFile = FreeFile
        Open ItemFile For Input Access Read As #Id_ClassFile
        Do While Not EOF(1)
            Line Input #Id_ClassFile, entradadatos
            If Left(entradadatos, 7) = "endweap" Then
                SeparadorTrobat = 1
            ElseIf Left(entradadatos, 2) <> "//" Then
                Dim NomActual As String
                Dim SegonNomActual As String
                Dim PosString As Integer
                Dim BuscaSegon As Boolean
                Dim StringTrobatInici As Boolean
                Dim Cometes As Boolean
                
                NomActual = ""
                SegonNomActual = ""
                PosString = 0
                BuscaSegon = False
                StringTrobatInici = False
                Cometes = False
                
                Do While PosString < Len(entradadatos)
                    If Not StringTrobatInici Then
                        If Mid(entradadatos, PosString + 1, 1) <> " " Then
                            StringTrobatInici = True
                        End If
                    End If
                    If StringTrobatInici Then
                        If Mid(entradadatos, PosString + 1, 1) = """" Then
                            If Not Cometes Then
                                Cometes = True
                            Else
                                Cometes = False
                                If Not BuscaSegon Then
                                    BuscaSegon = True
                                    StringTrobatInici = False
                                Else
                                    PosString = Len(entradadatos)
                                End If
                            End If
                        ElseIf Mid(entradadatos, PosString + 1, 1) <> " " Or Cometes Then
                               If Not BuscaSegon Then
                                    NomActual = NomActual + Mid(entradadatos, PosString + 1, 1)
                                Else
                                    SegonNomActual = SegonNomActual + Mid(entradadatos, PosString + 1, 1)
                                End If
                        Else
                                If Not BuscaSegon Then
                                    BuscaSegon = True
                                    StringTrobatInici = False
                                Else
                                    PosString = Len(entradadatos)
                                End If
                        End If
                    End If
                    PosString = PosString + 1
                Loop
                Rem Coloquem a la Taula
                If ((NomActual <> "") And (SegonNomActual <> "")) Then
                    ItemList(NumItems).classname = NomActual
                    ItemList(NumItems).PickupName = SegonNomActual
                    NumItems = NumItems + 1
                    If Not SeparadorTrobat Then
                        NumWeapons = NumWeapons + 1
                    End If
                End If
            End If
        Loop
        Close Id_ClassFile
    End If
Exit Sub
ErrHandler:
 MainForm.Show
 Exit Sub
End Sub
Private Sub Mods_Load(index As Integer)
    Dim ModFile As String
    
    On Error GoTo ErrHandler
    ModFile = GetSetting("WyrmEditor", "ModFile", "File", "")
    CommonDialog1.filename = ModFile
    If ModFile = "" Or index <> 0 Then
        CommonDialog1.DialogTitle = "Locate your modlist.txt file"
        CommonDialog1.Filter = "modlist.txt|modlist.txt|All (*.*)|*.*"
        CommonDialog1.FilterIndex = 1
        CommonDialog1.Flags = cdlOFNHideReadOnly + cdlOFNFileMustExist
        Rem CommonDialog1.ShowOpen
        OpenCM
        If (CommonDialog1.filename <> "") Then
            ItemFile = CommonDialog1.filename
            SaveSetting "WyrmEditor", "ModFile", "File", ItemFile
        End If
        MainForm.Show
    End If
    
    If ModFile <> "" Then
        NumMods = 0
        Id_ClassFile = FreeFile
        Open ModFile For Input Access Read As #Id_ClassFile
        Do While Not EOF(1)
            Line Input #Id_ClassFile, entradadatos
            If Left(entradadatos, 2) <> "//" Then
                Dim NomActual As String
                Dim SegonNomActual As String
                Dim PosString As Integer
                Dim BuscaSegon As Boolean
                Dim StringTrobatInici As Boolean
                Dim Cometes As Boolean
                
                NomActual = ""
                SegonNomActual = ""
                PosString = 0
                BuscaSegon = False
                StringTrobatInici = False
                Cometes = False
                
                Do While PosString < Len(entradadatos)
                    If Not StringTrobatInici Then
                        If Mid(entradadatos, PosString + 1, 1) <> " " Then
                            StringTrobatInici = True
                        End If
                    End If
                    If StringTrobatInici Then
                        If Mid(entradadatos, PosString + 1, 1) = """" Then
                            If Not Cometes Then
                                Cometes = True
                            Else
                                Cometes = False
                                If Not BuscaSegon Then
                                    BuscaSegon = True
                                    StringTrobatInici = False
                                Else
                                    PosString = Len(entradadatos)
                                End If
                            End If
                        ElseIf Mid(entradadatos, PosString + 1, 1) <> " " Or Cometes Then
                               If Not BuscaSegon Then
                                    NomActual = NomActual + Mid(entradadatos, PosString + 1, 1)
                                Else
                                    SegonNomActual = SegonNomActual + Mid(entradadatos, PosString + 1, 1)
                                End If
                        Else
                                If Not BuscaSegon Then
                                    BuscaSegon = True
                                    StringTrobatInici = False
                                Else
                                    PosString = Len(entradadatos)
                                End If
                        End If
                    End If
                    PosString = PosString + 1
                Loop
                Rem Coloquem a la Taula
                If ((NomActual <> "") And (SegonNomActual <> "")) Then
                    ModList(NumMods).realname = NomActual
                    ModList(NumMods).name = SegonNomActual
                    NumMods = NumMods + 1
                End If
            End If
        Loop
        Close Id_ClassFile
    End If
Exit Sub
ErrHandler:
 MainForm.Show
 Exit Sub
End Sub

Private Sub MDIForm_Load()
    Items_Load 0
    Mods_Load 0
    ' La aplicación empieza aquí (evento Load del formulario Startup).
    Show
    ' Siempre establece el directorio de trabajo al directorio que contiene la aplicación.
    ChDir App.Path

    Class_Activated = False
    RC_Activated = False
    RWS_Activated = False
    Keys_Activated = False
End Sub

Private Sub MDIForm_Terminate()
    MenuExit_Click
End Sub

Private Sub MDIForm_Unload(Cancel As Integer)
    MenuExit_Click
End Sub

Private Sub MenuAbout_Click()
    frmAbout.Show vbModal
End Sub

Private Sub MenuClose_Click()
    If Class_Activated Then
        Unload Form1
    End If
    If RC_Activated Then
        Unload Form2
    End If
    If RWS_Activated Then
        Unload Form3
    End If
    Rem if Keys_Activated then
    Rem unload form4
    Rem endif
End Sub

Private Sub MenuCloseClass_Click()
    Form1.MenuExit_Click
End Sub

Private Sub MenuCloseRC_Click()
    Form2.Command8_Click
End Sub

Private Sub MenuCloseRWS_Click()
    Form3.Command4_Click
End Sub

Private Sub MenuExit_Click()
    End
End Sub

Private Sub MenuItemlist_Click()
    Items_Load 1
End Sub

Private Sub MenuModList_Click()
    Mods_Load 1
End Sub

Private Sub MenuNewClass_Click()
    New_Class_File = ""
    If Class_Activated Then
        Form1.Form_Load
    Else
        Load Form1
    End If
End Sub

Private Sub MenuNewRC_Click()
    New_RC_File = ""
    If RC_Activated Then
        Form2.Form_Load
    Else
        Load Form2
    End If
End Sub

Private Sub MenuNewRWS_Click()
    New_RWS_File = ""
    If RWS_Activated Then
        Form3.Form_Load
    Else
        Load Form3
    End If
End Sub

Private Sub MenuOpenClass2_Click()
    Form1.OpenFile_Click
End Sub

Private Sub MenuOpenRC_Click()
    On Error GoTo ErrHandler
    CommonDialog1.filename = ""
    CommonDialog1.DialogTitle = "Choose RC File"
    CommonDialog1.Filter = "RC file (*.rc)|*.rc|All (*.*)|*.*"
    CommonDialog1.FilterIndex = 1
    CommonDialog1.Flags = cdlOFNHideReadOnly + cdlOFNFileMustExist
    Rem CommonDialog1.ShowOpen
    OpenCM
    If (CommonDialog1.filename <> "") Then
        New_RC_File = CommonDialog1.filename
        If RC_Activated Then
            Form2.Form_Load
        Else
            Load Form2
        End If
    End If
Exit Sub
ErrHandler:
 MainForm.Show
 Exit Sub
End Sub

Private Sub MenuOpenClass_Click()
 On Error GoTo ErrHandler
 CommonDialog1.filename = ""
 CommonDialog1.DialogTitle = "Choose Class File"
 CommonDialog1.Filter = "Class file (*.class)|*.class|All (*.*)|*.*"
 CommonDialog1.FilterIndex = 1
 CommonDialog1.Flags = cdlOFNHideReadOnly + cdlOFNFileMustExist
 Rem CommonDialog1.ShowOpen
 OpenCM
 If (CommonDialog1.filename <> "") Then
    New_Class_File = CommonDialog1.filename
    If Class_Activated Then
        Form1.Form_Load
    Else
        Load Form1
    End If
 End If
Exit Sub
ErrHandler:
 MainForm.Show
 Exit Sub
End Sub

Private Sub MenuOpenRC2_Click()
    Form2.Command5_Click
End Sub

Private Sub MenuOpenRWS_Click()
 On Error GoTo ErrHandler
 CommonDialog1.filename = ""
 CommonDialog1.DialogTitle = "Choose RWS File"
 CommonDialog1.Filter = "RWS file (*.rws)|*.rws|All (*.*)|*.*"
 CommonDialog1.FilterIndex = 1
 CommonDialog1.Flags = cdlOFNHideReadOnly + cdlOFNFileMustExist
 Rem CommonDialog1.ShowOpen
 OpenCM
 If (CommonDialog1.filename <> "") Then
    New_RWS_File = CommonDialog1.filename
    If RWS_Activated Then
        Form3.Form_Load
    Else
        Load Form3
    End If
 End If
Exit Sub
ErrHandler:
 MainForm.Show
 Exit Sub
End Sub

Private Sub MenuOpenRWS2_Click()
    Form3.Command1_Click
End Sub

Private Sub MenuSave_Click()
    If Class_Activated And FileChanged Then
        MenuSaveClass_Click
    End If
    If RC_Activated And RCChanged Then
        MenuSaveRC_Click
    End If
    If RWS_Activated And RWSChanged Then
        MenuSaveRWS_Click
    End If
    Rem if Keys_Activated and KeysChanged then
    Rem
    Rem endif
End Sub

Private Sub MenuSaveAs_Click()
    If Class_Activated Then
        MenuSaveAsClass_Click
    End If
    If RC_Activated Then
        MenuSaveAsRC_Click
    End If
    If RWS_Activated Then
        MenuSaveAsRWS_Click
    End If
    Rem if Keys_Activated then
    Rem
    Rem endif
End Sub

Private Sub MenuSaveAsClass_Click()
    Form1.MenuSaveAs_Click
End Sub

Private Sub MenuSaveAsRC_Click()
    Form2.Command7_Click
End Sub

Private Sub MenuSaveAsRWS_Click()
    Form3.Command3_Click
End Sub

Private Sub MenuSaveClass_Click()
    Form1.MenuSave_Click
End Sub

Private Sub MenuSaveRC_Click()
    Form2.Command6_Click
End Sub

Private Sub MenuSaveRWS_Click()
    Form3.Command2_Click
End Sub
