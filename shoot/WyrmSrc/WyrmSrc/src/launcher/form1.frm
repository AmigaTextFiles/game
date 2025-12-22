VERSION 5.00
Begin VB.Form Form1 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Wyrm Launcher"
   ClientHeight    =   5325
   ClientLeft      =   1935
   ClientTop       =   1935
   ClientWidth     =   8400
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   Picture         =   "Form1.frx":058A
   ScaleHeight     =   5325
   ScaleWidth      =   8400
   Begin VB.PictureBox Picture5 
      Height          =   375
      Left            =   4440
      Picture         =   "Form1.frx":18A2A
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   29
      Top             =   4560
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.PictureBox Picture4 
      Height          =   375
      Left            =   3600
      Picture         =   "Form1.frx":1C906
      ScaleHeight     =   315
      ScaleWidth      =   315
      TabIndex        =   28
      Top             =   4560
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   4680
      Top             =   120
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   5880
      TabIndex        =   27
      Top             =   3480
      Width           =   2175
   End
   Begin VB.PictureBox Picture3 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H80000008&
      Height          =   2775
      Left            =   120
      Picture         =   "Form1.frx":207E2
      ScaleHeight     =   2745
      ScaleWidth      =   4185
      TabIndex        =   26
      Top             =   720
      Width           =   4215
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H80000012&
      BorderStyle     =   0  'None
      Height          =   255
      Left            =   5880
      TabIndex        =   21
      Top             =   2040
      Width           =   2175
      Begin VB.OptionButton Skill0 
         BackColor       =   &H00000000&
         Caption         =   "Skill"
         Height          =   255
         Left            =   0
         TabIndex        =   25
         Top             =   0
         Width           =   255
      End
      Begin VB.OptionButton Skill1 
         BackColor       =   &H00000000&
         Caption         =   "Skill"
         Height          =   255
         Left            =   600
         TabIndex        =   24
         Top             =   0
         Value           =   -1  'True
         Width           =   255
      End
      Begin VB.OptionButton Skill2 
         BackColor       =   &H00000000&
         Caption         =   "Skill"
         Height          =   255
         Left            =   1200
         TabIndex        =   23
         Top             =   0
         Width           =   255
      End
      Begin VB.OptionButton Skill3 
         BackColor       =   &H00000000&
         Caption         =   "Skill"
         Height          =   255
         Left            =   1800
         TabIndex        =   22
         Top             =   0
         Width           =   255
      End
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   5880
      TabIndex        =   20
      Text            =   "Base1"
      Top             =   2640
      Width           =   1455
   End
   Begin VB.OptionButton Option4 
      BackColor       =   &H00000000&
      Caption         =   "Option1"
      Height          =   255
      Left            =   7680
      TabIndex        =   12
      Top             =   840
      Width           =   255
   End
   Begin VB.OptionButton Option3 
      BackColor       =   &H00000000&
      Caption         =   "Option1"
      Height          =   255
      Left            =   7080
      TabIndex        =   10
      Top             =   840
      Width           =   255
   End
   Begin VB.OptionButton Option2 
      BackColor       =   &H00000000&
      Caption         =   "Option1"
      Height          =   255
      Left            =   6480
      TabIndex        =   8
      Top             =   840
      Width           =   255
   End
   Begin VB.OptionButton Option1 
      BackColor       =   &H00000000&
      Caption         =   "Option1"
      Height          =   255
      Left            =   5880
      TabIndex        =   6
      Top             =   840
      Value           =   -1  'True
      Width           =   255
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   5880
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   1320
      Width           =   2175
   End
   Begin VB.PictureBox Picture2 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   1155
      Left            =   5280
      MousePointer    =   10  'Up Arrow
      Picture         =   "Form1.frx":2CCEE
      ScaleHeight     =   77
      ScaleMode       =   3  'Píxel
      ScaleWidth      =   201
      TabIndex        =   1
      Top             =   4080
      Width           =   3015
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   1155
      Left            =   240
      MousePointer    =   10  'Up Arrow
      Picture         =   "Form1.frx":30BCA
      ScaleHeight     =   77
      ScaleMode       =   3  'Píxel
      ScaleWidth      =   205
      TabIndex        =   0
      Top             =   4080
      Width           =   3075
   End
   Begin VB.Label Label13 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      Caption         =   "Starting Map:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   3840
      TabIndex        =   19
      Top             =   2640
      Width           =   1935
   End
   Begin VB.Label Label12 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "HELL"
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   7440
      TabIndex        =   18
      Top             =   1800
      Width           =   735
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "Normal"
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   6240
      TabIndex        =   16
      Top             =   1800
      Width           =   735
   End
   Begin VB.Label Label11 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "Hard"
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   6840
      TabIndex        =   17
      Top             =   1800
      Width           =   735
   End
   Begin VB.Label Label9 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "Easy"
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   5640
      TabIndex        =   15
      Top             =   1800
      Width           =   615
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      Caption         =   "Skill:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   5160
      TabIndex        =   14
      Top             =   2040
      Width           =   615
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "SP"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   5760
      TabIndex        =   7
      Top             =   600
      Width           =   495
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "CTF"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   7440
      TabIndex        =   13
      Top             =   600
      Width           =   735
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "DM"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   6960
      TabIndex        =   11
      Top             =   600
      Width           =   495
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "COOP"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   6120
      TabIndex        =   9
      Top             =   600
      Width           =   975
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      Caption         =   "Game Type:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   4440
      TabIndex        =   5
      Top             =   840
      Width           =   1335
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      Caption         =   "Other Options:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   3600
      TabIndex        =   4
      Top             =   3480
      Width           =   2175
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      Caption         =   "Class Setter:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   3960
      TabIndex        =   3
      Top             =   1320
      Width           =   1815
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Id_Actual As Integer
Dim play As Boolean

Private Sub Form_Load()
    Dim Name, Actual, filedata
    Dim added As Boolean
    '
    ' centra el formulario
    '
    Me.Move (Screen.Width - Me.Width) / 2, (Screen.Height - Me.Height) / 2
    
    play = False
    added = False
    
    ChDir App.Path
    
    Combo1.Clear
    
    Name = Dir("*.rc", vbNormal)
    Do While Name <> ""
        
        Id_Actual = FreeFile
        Open Name For Input Access Read As #Id_Actual
        Line Input #Id_Actual, filedata
        If filedata = "//LAUNCHER: RC File <-- Don't Remove!!!" Then
            Combo1.AddItem Left(Name, Len(Name) - 3)
            added = True
        End If
        Close #Id_Actual
        Name = Dir
    Loop
    If Not added Then
        Combo1.Enabled = False
    End If
End Sub

Private Sub Form_Terminate()
    End
End Sub

Private Sub Form_Unload(Cancel As Integer)
    End
End Sub

Private Sub Picture1_Click()
    If Not Timer1.Enabled Then
        play = True
        Timer1.Enabled = True
        Picture1.Picture = Picture4.Picture
    End If
End Sub

Private Sub Picture2_Click()
    If Not Timer1.Enabled Then
        Timer1.Enabled = True
        Picture2.Picture = Picture5.Picture
    End If
End Sub

Private Sub Timer1_Timer()
 On Error GoTo ErrHandler
    If play Then
        Dim argumento As String
        
        argumento = "quake2 +set game wyrm"
        
        If Option2.Value Then
            argumento = argumento + " +set coop 1"
        ElseIf Option3.Value Then
            argumento = argumento + " +set deathmatch 1"
        ElseIf Option4.Value Then
            argumento = argumento + " +set ctf 1"
        End If
        If Skill0.Value Then
            argumento = argumento + " +set skill 0"
        ElseIf Skill1.Value Then
            argumento = argumento + " +set skill 1"
        ElseIf Skill2.Value Then
            argumento = argumento + " +set skill 2"
        ElseIf Skill3.Value Then
            argumento = argumento + " +set skill 3"
        End If
        
        If (Combo1.ListIndex > -1) Then
            argumento = argumento + " +exec " + Combo1.List(Combo1.ListIndex) + ".rc"
        End If
        argumento = argumento + " " + Text2.Text
        If (Text1.Text <> "") Then
            argumento = argumento + " +map " + Text1.Text
        End If
        
        Rem Go to the Quake 2 directory
        ChDir (App.Path)
        ChDir ("..")
        Call Shell(argumento, 1)
    End If
    
    End
ErrHandler:
    res = MsgBox("Quake2.exe hasn't been found! Did you installed Wyrm into the right directory?", vbOKOnly, "Error!")
End
End Sub
