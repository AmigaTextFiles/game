VERSION 5.00
Begin VB.Form Form2 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Wyrm Class Setter File"
   ClientHeight    =   5040
   ClientLeft      =   3780
   ClientTop       =   2475
   ClientWidth     =   5025
   Enabled         =   0   'False
   Icon            =   "Form2.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5040
   ScaleWidth      =   5025
   Begin VB.CheckBox Check5 
      Caption         =   "Check5"
      Height          =   195
      Left            =   2640
      TabIndex        =   22
      Top             =   480
      Width           =   255
   End
   Begin VB.CheckBox Check2 
      Caption         =   "Check2"
      Height          =   195
      Left            =   2640
      TabIndex        =   20
      Top             =   120
      Width           =   255
   End
   Begin VB.Frame Frame1 
      Caption         =   "Other Options"
      Height          =   2295
      Left            =   240
      TabIndex        =   18
      Top             =   1920
      Width           =   4455
      Begin VB.TextBox Text3 
         Height          =   1935
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   19
         Top             =   240
         Width           =   4215
      End
   End
   Begin VB.CommandButton Command8 
      Caption         =   "Close"
      Height          =   615
      Left            =   3720
      TabIndex        =   17
      Top             =   4320
      Width           =   735
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Save as"
      Height          =   615
      Left            =   2760
      TabIndex        =   16
      Top             =   4320
      Width           =   735
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Save"
      Enabled         =   0   'False
      Height          =   615
      Left            =   1680
      TabIndex        =   15
      Top             =   4320
      Width           =   735
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Open"
      Height          =   615
      Left            =   600
      TabIndex        =   14
      Top             =   4320
      Width           =   735
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Edit"
      Height          =   255
      Left            =   3840
      TabIndex        =   13
      Top             =   1560
      Width           =   855
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Browse..."
      Height          =   255
      Left            =   2880
      TabIndex        =   12
      Top             =   1560
      Width           =   855
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Edit"
      Height          =   255
      Left            =   3840
      TabIndex        =   11
      Top             =   1200
      Width           =   855
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Browse..."
      Height          =   255
      Left            =   2880
      TabIndex        =   10
      Top             =   1200
      Width           =   855
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   1320
      TabIndex        =   9
      Top             =   1560
      Width           =   1455
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   1320
      TabIndex        =   8
      Top             =   1200
      Width           =   1455
   End
   Begin VB.CheckBox Check4 
      Caption         =   "Check3"
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   840
      Width           =   255
   End
   Begin VB.CheckBox Check3 
      Caption         =   "Check3"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   480
      Width           =   255
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Check1"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   255
   End
   Begin VB.Label Label7 
      Caption         =   "Disable Changing Frames"
      Height          =   255
      Left            =   3000
      TabIndex        =   23
      Top             =   480
      Width           =   2055
   End
   Begin VB.Label Label2 
      Caption         =   "Disable Footsteps"
      Height          =   255
      Left            =   3000
      TabIndex        =   21
      Top             =   120
      Width           =   1815
   End
   Begin VB.Label Label6 
      Caption         =   "Set Custom Class Keys"
      Height          =   255
      Left            =   600
      TabIndex        =   7
      Top             =   840
      Width           =   2055
   End
   Begin VB.Label Label5 
      Caption         =   "RWS File:"
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   1560
      Width           =   1455
   End
   Begin VB.Label Label4 
      Caption         =   "Class File:"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   1200
      Width           =   1455
   End
   Begin VB.Label Label3 
      Caption         =   "Set Custom Class Skins"
      Height          =   255
      Left            =   600
      TabIndex        =   3
      Top             =   480
      Width           =   2055
   End
   Begin VB.Label Label1 
      Caption         =   "Activate Classes"
      Height          =   255
      Left            =   600
      TabIndex        =   1
      Top             =   120
      Width           =   1215
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Id_RCFile As Integer
Private Sub MenuClose_Click()
    Dim sortir As Boolean
    Dim Seleccio As Integer
    
    sortir = False
    
    If (RCChanged) Then
        Seleccio = MsgBox("The RC File has been changed. Do you want to keep the changes?", vbYesNoCancel, "Warning!")
        If Seleccio = vbYes Then
            RC_Save 0
            sortir = True
        ElseIf Seleccio = vbNo Then
            Rem Surt sense gravar
            sortir = True
        End If
        Rem si cancel, no fem res
    Else
        Rem sortir sense preguntar
        sortir = True
    End If

    If sortir Then
        Form2.Enabled = False
        RC_Activated = False
        Unload Me
        MainForm.MenuRC.Enabled = False
    End If
    MainForm.Show
End Sub

Private Sub Check1_Click()
    RCChanged = True
    Command6.Enabled = True
End Sub

Private Sub Check2_Click()
    RCChanged = True
    Command6.Enabled = True
End Sub

Private Sub Check3_Click()
    RCChanged = True
    Command6.Enabled = True
End Sub

Private Sub Check4_Click()
    RCChanged = True
    Command6.Enabled = True
End Sub

Private Sub Check5_Click()
    RCChanged = True
    Command6.Enabled = True
End Sub

Private Sub Command1_Click()
 On Error GoTo ErrHandler
 MainForm.CommonDialog1.filename = Text1.Text
 MainForm.CommonDialog1.DialogTitle = "Choose Class File"
 MainForm.CommonDialog1.Filter = "Class file (*.class)|*.class|All (*.*)|*.*"
 MainForm.CommonDialog1.FilterIndex = 1
 MainForm.CommonDialog1.Flags = cdlOFNHideReadOnly
 Rem MainForm.CommonDialog1.ShowOpen
 OpenCM
 If (MainForm.CommonDialog1.filename <> "") Then
    Dim Llargada As Integer
    Dim LlargadaOrg As Integer
    
    Llargada = Len(MainForm.CommonDialog1.filename)
    LlargadaOrg = Llargada
    Do While (Mid(MainForm.CommonDialog1.filename, Llargada, 1) <> "\") And Llargada > 0
        Llargada = Llargada - 1
    Loop
    MainForm.CommonDialog1.filename = Right(MainForm.CommonDialog1.filename, LlargadaOrg - Llargada)
     
     If (MainForm.CommonDialog1.filename <> Text1.Text) Then
         RCChanged = True
         Command6.Enabled = True
         If MainForm.CommonDialog1.filename <> "" Then
            Command2.Enabled = True
         Else
            Command2.Enabled = False
         End If
     End If
     Text1.Text = MainForm.CommonDialog1.filename
 End If
 Rem MainForm.Show
Exit Sub
ErrHandler:
  Rem MainForm.Show
  Exit Sub
End Sub

Private Sub Command2_Click()
    If Text1.Text = "" Then
        Exit Sub
    End If
    New_Class_File = Text1.Text
    If Class_Activated Then
        Form1.Form_Load
    Else
        Load Form1
    End If
End Sub

Private Sub Command3_Click()
 On Error GoTo ErrHandler
 MainForm.CommonDialog1.filename = Text2.Text
 MainForm.CommonDialog1.DialogTitle = "Choose RWS File"
 MainForm.CommonDialog1.Filter = "RWS file (*.rws)|*.rws|All (*.*)|*.*"
 MainForm.CommonDialog1.FilterIndex = 1
 MainForm.CommonDialog1.Flags = cdlOFNHideReadOnly
 Rem CommonDialog1.ShowOpen
 OpenCM
 If (MainForm.CommonDialog1.filename <> "") Then
    Dim Llargada As Integer
    Dim LlargadaOrg As Integer
    Llargada = Len(MainForm.CommonDialog1.filename)
    LlargadaOrg = Llargada
    Do While Mid(MainForm.CommonDialog1.filename, Llargada, 1) <> "\" And Llargada > 0
        Llargada = Llargada - 1
    Loop
    MainForm.CommonDialog1.filename = Right(MainForm.CommonDialog1.filename, LlargadaOrg - Llargada)
     If (MainForm.CommonDialog1.filename <> Text2.Text) Then
         RCChanged = True
        Command6.Enabled = True
         If MainForm.CommonDialog1.filename <> "" Then
            Command4.Enabled = True
         Else
            Command4.Enabled = False
         End If
     End If
    Text2.Text = MainForm.CommonDialog1.filename
 End If
 Rem MainForm.Show
 Exit Sub
ErrHandler:
  Rem MainForm.Show
  Exit Sub
End Sub

Private Sub Command4_Click()
    If Text2.Text = "" Then
        Exit Sub
    End If
    New_RWS_File = Text2.Text
    If RWS_Activated Then
        Form3.Form_Load
    Else
        Load Form3
    End If
End Sub

Sub Command5_Click()
 On Error GoTo ErrHandler
 MainForm.CommonDialog1.filename = RC_File
 MainForm.CommonDialog1.DialogTitle = "Open RC File..."
 MainForm.CommonDialog1.Filter = "RC file (*.rc)|*.rc|All (*.*)|*.*"
 MainForm.CommonDialog1.FilterIndex = 1
 MainForm.CommonDialog1.Flags = cdlOFNHideReadOnly
 Rem CommonDialog1.ShowOpen
 OpenCM
 If MainForm.CommonDialog1.filename <> "" And MainForm.CommonDialog1.filename <> RC_File Then
    New_RC_File = MainForm.CommonDialog1.filename
    Form_Load
 End If
 Rem MainForm.Show
Exit Sub
ErrHandler:
 Rem MainForm.Show
 Exit Sub
End Sub

Sub Command6_Click()
    RC_Save 0
End Sub

Sub Command7_Click()
    RC_Save 1
End Sub

Sub Command8_Click()
    MenuClose_Click
End Sub
Private Sub RC_Save(index As Integer)
    Rem si no RC_File, demana nom
    If RC_File = "" Or index <> 0 Then
        Rem demanar nom fitxer
        On Error GoTo ErrHandler
        MainForm.CommonDialog1.filename = RC_File
        MainForm.CommonDialog1.DialogTitle = "Save As..."
        MainForm.CommonDialog1.Filter = "RC file (*.rc)|*.rc|All (*.*)|*.*"
        MainForm.CommonDialog1.FilterIndex = 1
        MainForm.CommonDialog1.Flags = cdlOFNHideReadOnly + cdlOFNPathMustExist + cdlOFNOverwritePrompt
        Rem CommonDialog1.ShowSave
        SaveCM
        Rem mirar si existeix?
        RC_File = MainForm.CommonDialog1.filename
        Rem MainForm.Show
    End If
    Command6.Enabled = False
    RCChanged = False
    If RC_File <> "" Then
        Id_RCFile = FreeFile
        Open RC_File For Output Access Write As #Id_RCFile
        Print #Id_RCFile, "//LAUNCHER: RC File"
        Print #Id_RCFile, "//"
        Print #Id_RCFile, "//File generated by Wyrm RC Editor"
        Print #Id_RCFile, "//"
        If Check1.Value Then
            Print #Id_RCFile, "set enableclass 1"
        Else
            Print #Id_RCFile, "set enableclass 0"
        End If
        If Check3.Value Then
            Print #Id_RCFile, "set setclassskin 1"
        Else
            Print #Id_RCFile, "set setclassskin 0"
        End If
        If Check4.Value Then
            Print #Id_RCFile, "set setclasskeys 1"
        Else
            Print #Id_RCFile, "set setclasskeys 0"
        End If
        If Check2.Value Then
            Print #Id_RCFile, "set footsteps 0"
        Else
            Print #Id_RCFile, "set footsteps 1"
        End If
        If Check5.Value Then
            Print #Id_RCFile, "set changeframes 0"
        Else
            Print #Id_RCFile, "set changeframes 1"
        End If
        If Trim(Text1.Text) <> "" Then
            Print #Id_RCFile, "set classfile "; Text1.Text
        End If
        If Trim(Text2.Text) <> "" Then
            Print #Id_RCFile, "set rwcfgin "; Text2.Text
        End If
        If Trim(Text3.Text) <> "" Then
            Print #Id_RCFile, "//Other Options..."
            Print #Id_RCFile, Text3.Text
        End If
        Close Id_RCFile
    End If
Exit Sub
ErrHandler:
  Rem MainForm.Show
  Exit Sub
End Sub

Private Sub RC_Load()
    Command6.Enabled = False
    
    RCChanged = False

    If (RC_File <> "") Then
        Text3.Text = ""
        Text1.Text = ""
        Text2.Text = ""
        Command2.Enabled = False
        Command4.Enabled = False

        Id_RCFile = FreeFile
        Open RC_File For Input Access Read As #Id_RCFile
        trobatinici = False
        Do While Not EOF(1)
            Line Input #Id_RCFile, entradadatos
            tempdatos = LCase(Trim(entradadatos))
            If Left(entradadatos, 2) <> "//" Then
                If Left(tempdatos, 4) = "set " Then
                    tempdatos = Trim(Right(tempdatos, Len(tempdatos) - 4))
                    If Left(tempdatos, 11) = "enableclass" Then
                        tempdatos = Trim(Right(tempdatos, Len(tempdatos) - 11))
                        If Val(tempdatos) = 0 Then
                            Check1.Value = 0
                        Else
                            Check1.Value = 1
                        End If
                    ElseIf Left(tempdatos, 12) = "setclassskin" Then
                        tempdatos = Trim(Right(tempdatos, Len(tempdatos) - 12))
                        If Val(tempdatos) = 0 Then
                            Check3.Value = 0
                        Else
                            Check3.Value = 1
                        End If
                    ElseIf Left(tempdatos, 12) = "setclasskeys" Then
                        tempdatos = Trim(Right(tempdatos, Len(tempdatos) - 12))
                        If Val(tempdatos) = 0 Then
                            Check4.Value = 0
                        Else
                            Check4.Value = 1
                        End If
                    ElseIf Left(tempdatos, 9) = "footsteps" Then
                        tempdatos = Trim(Right(tempdatos, Len(tempdatos) - 9))
                        If Val(tempdatos) = 0 Then
                            Check2.Value = 1
                        Else
                            Check2.Value = 0
                        End If
                    ElseIf Left(tempdatos, 12) = "changeframes" Then
                        tempdatos = Trim(Right(tempdatos, Len(tempdatos) - 12))
                        If Val(tempdatos) = 0 Then
                            Check5.Value = 1
                        Else
                            Check5.Value = 0
                        End If
                    ElseIf Left(tempdatos, 9) = "classfile" Then
                        tempdatos = Trim(Right(tempdatos, Len(tempdatos) - 9))
                        Text1.Text = tempdatos
                        Command2.Enabled = True
                    ElseIf Left(tempdatos, 7) = "rwcfgin" Then
                        tempdatos = Trim(Right(tempdatos, Len(tempdatos) - 7))
                        Text2.Text = tempdatos
                        Command4.Enabled = True
                    Else
                        Rem afegir a other options
                        Text3.Text = Text3.Text + entradadatos + Chr(13) + Chr(10)
                    End If
                Else
                    Rem afegir a other options
                    Text3.Text = Text3.Text + entradadatos + Chr(13) + Chr(10)
                End If
            End If
        Loop
        Close Id_RCFile
    Else
        Rem netejar fitxa
        Check1.Value = False
        Check3.Value = False
        Check4.Value = False
        Check2.Value = False
        Check5.Value = False
        Text1.Text = ""
        Text2.Text = ""
        Text3.Text = ""
        Command2.Enabled = False
        Command4.Enabled = False
    End If
    RCChanged = False
    Command6.Enabled = False
End Sub

Private Function Anterior() As Boolean
    Dim Seleccio As Integer
    
    Rem Mirar si filechanged... :P
    If (RCChanged) Then
        Seleccio = MsgBox("The RC File has changed. Do you want to keep the changes?", vbYesNoCancel, "Warning!")
        If Seleccio = vbYes Then
            RC_Save 0
            Anterior = False
        ElseIf Seleccio = vbNo Then
            Rem Surt sense gravar
            Anterior = False
        Else
            Rem si cancel, no fem res
            Anterior = True
        End If
            
    End If
End Function

Sub Form_Load()
    Dim retorn As Boolean
    retorn = False
    If RC_Activated Then
        retorn = Anterior
    End If
    If Not retorn Then
        RC_File = New_RC_File
        RC_Load
        RC_Activated = True
        Enabled = True
        MainForm.MenuRC.Enabled = True
    End If
End Sub
Sub Form_Terminate()
    If RC_Activated Then
        MenuClose_Click
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    If RC_Activated Then
        MenuClose_Click
    End If
End Sub

Private Sub Label1_Click()
    If (Check1.Value <> 0) Then
        Check1.Value = 0
        RCChanged = True
        Command6.Enabled = True
    Else
        Check1.Value = 1
        RCChanged = True
        Command6.Enabled = True
    End If
End Sub

Private Sub Label2_Click()
    If (Check2.Value <> 0) Then
        Check2.Value = 0
        RCChanged = True
        Command6.Enabled = True
    Else
        Check2.Value = 1
        RCChanged = True
        Command6.Enabled = True
    End If
End Sub

Private Sub Label3_Click()
    If (Check3.Value <> 0) Then
        Check3.Value = 0
        RCChanged = True
        Command6.Enabled = True
    Else
        Check3.Value = 1
        RCChanged = True
        Command6.Enabled = True
    End If
End Sub

Private Sub Label6_Click()
    If (Check4.Value <> 0) Then
        Check4.Value = 0
        RCChanged = True
        Command6.Enabled = True
    Else
        Check4.Value = 1
        RCChanged = True
        Command6.Enabled = True
    End If
End Sub

Private Sub Label7_Click()
    If (Check5.Value <> 0) Then
        Check5.Value = 0
        RCChanged = True
        Command6.Enabled = True
    Else
        Check5.Value = 1
        RCChanged = True
        Command6.Enabled = True
    End If
End Sub

Private Sub Text1_Change()
    RCChanged = True
    Command6.Enabled = True
    If Text1.Text <> "" Then
        Command2.Enabled = True
    Else
        Command2.Enabled = False
    End If
End Sub

Private Sub Text2_Change()
    RCChanged = True
    Command6.Enabled = True
    If Text2.Text <> "" Then
        Command4.Enabled = True
    Else
        Command4.Enabled = False
    End If
End Sub

Private Sub Text3_Change()
    RCChanged = True
    Command6.Enabled = True
End Sub
