VERSION 5.00
Begin VB.Form Form5 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Class Armors"
   ClientHeight    =   2445
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6975
   Icon            =   "Form5.frx":0000
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2445
   ScaleWidth      =   6975
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   3720
      TabIndex        =   28
      Top             =   1920
      Width           =   1695
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   1560
      TabIndex        =   27
      Top             =   1920
      Width           =   1695
   End
   Begin VB.Frame Frame3 
      Caption         =   "Body Armor"
      Height          =   1695
      Index           =   2
      Left            =   4800
      TabIndex        =   18
      Top             =   120
      Width           =   2055
      Begin VB.TextBox Text12 
         Height          =   285
         Index           =   2
         Left            =   1440
         TabIndex        =   22
         Text            =   "Text4"
         Top             =   1320
         Width           =   495
      End
      Begin VB.TextBox Text11 
         Height          =   285
         Index           =   2
         Left            =   1440
         TabIndex        =   21
         Text            =   "Text3"
         Top             =   960
         Width           =   495
      End
      Begin VB.TextBox Text10 
         Height          =   285
         Index           =   2
         Left            =   1440
         TabIndex        =   20
         Text            =   "Text2"
         Top             =   600
         Width           =   495
      End
      Begin VB.TextBox Text9 
         Height          =   285
         Index           =   2
         Left            =   1440
         TabIndex        =   19
         Text            =   "Text1"
         Top             =   240
         Width           =   495
      End
      Begin VB.Label Label4 
         Caption         =   "VS Energy"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   26
         Top             =   1320
         Width           =   1215
      End
      Begin VB.Label Label3 
         Caption         =   "Normal Protection"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   25
         Top             =   960
         Width           =   1335
      End
      Begin VB.Label Label2 
         Caption         =   "Max Count"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   24
         Top             =   600
         Width           =   855
      End
      Begin VB.Label Label1 
         Caption         =   "Base Count"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   23
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Combat Armor"
      Height          =   1695
      Index           =   1
      Left            =   2400
      TabIndex        =   9
      Top             =   120
      Width           =   2055
      Begin VB.TextBox Text5 
         Height          =   285
         Index           =   1
         Left            =   1440
         TabIndex        =   13
         Text            =   "Text1"
         Top             =   240
         Width           =   495
      End
      Begin VB.TextBox Text6 
         Height          =   285
         Index           =   1
         Left            =   1440
         TabIndex        =   12
         Text            =   "Text2"
         Top             =   600
         Width           =   495
      End
      Begin VB.TextBox Text7 
         Height          =   285
         Index           =   1
         Left            =   1440
         TabIndex        =   11
         Text            =   "Text3"
         Top             =   960
         Width           =   495
      End
      Begin VB.TextBox Text8 
         Height          =   285
         Index           =   1
         Left            =   1440
         TabIndex        =   10
         Text            =   "Text4"
         Top             =   1320
         Width           =   495
      End
      Begin VB.Label Label1 
         Caption         =   "Base Count"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   17
         Top             =   240
         Width           =   975
      End
      Begin VB.Label Label2 
         Caption         =   "Max Count"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   16
         Top             =   600
         Width           =   855
      End
      Begin VB.Label Label3 
         Caption         =   "Normal Protection"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   15
         Top             =   960
         Width           =   1335
      End
      Begin VB.Label Label4 
         Caption         =   "VS Energy"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   14
         Top             =   1320
         Width           =   1215
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Jacket Armor"
      Height          =   1695
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2055
      Begin VB.TextBox Text4 
         Height          =   285
         Index           =   0
         Left            =   1440
         TabIndex        =   8
         Text            =   "Text4"
         Top             =   1320
         Width           =   495
      End
      Begin VB.TextBox Text3 
         Height          =   285
         Index           =   0
         Left            =   1440
         TabIndex        =   7
         Text            =   "Text3"
         Top             =   960
         Width           =   495
      End
      Begin VB.TextBox Text2 
         Height          =   285
         Index           =   0
         Left            =   1440
         TabIndex        =   6
         Text            =   "Text2"
         Top             =   600
         Width           =   495
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Index           =   0
         Left            =   1440
         TabIndex        =   5
         Text            =   "Text1"
         Top             =   240
         Width           =   495
      End
      Begin VB.Label Label4 
         Caption         =   "VS Energy"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   4
         Top             =   1320
         Width           =   1215
      End
      Begin VB.Label Label3 
         Caption         =   "Normal Protection"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Top             =   960
         Width           =   1335
      End
      Begin VB.Label Label2 
         Caption         =   "Max Count"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   2
         Top             =   600
         Width           =   855
      End
      Begin VB.Label Label1 
         Caption         =   "Base Count"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   975
      End
   End
End
Attribute VB_Name = "Form5"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    If ClassTbl(ActualClass).jacketarmor.base <> Val(Text1(0).Text) Then
        ClassTbl(ActualClass).jacketarmor.base = Val(Text1(0).Text)
        FileChanged = True
    End If
    If ClassTbl(ActualClass).jacketarmor.max <> Val(Text2(0).Text) Then
        ClassTbl(ActualClass).jacketarmor.max = Val(Text2(0).Text)
        FileChanged = True
    End If
    If ClassTbl(ActualClass).jacketarmor.normal <> Val(Text3(0).Text) Then
        ClassTbl(ActualClass).jacketarmor.normal = Val(Text3(0).Text)
        FileChanged = True
    End If
    If ClassTbl(ActualClass).jacketarmor.energy <> Val(Text4(0).Text) Then
        ClassTbl(ActualClass).jacketarmor.energy = Val(Text4(0).Text)
        FileChanged = True
    End If
    If ClassTbl(ActualClass).combatarmor.base <> Val(Text5(1).Text) Then
        ClassTbl(ActualClass).combatarmor.base = Val(Text5(1).Text)
        FileChanged = True
    End If
    If ClassTbl(ActualClass).combatarmor.max <> Val(Text6(1).Text) Then
        ClassTbl(ActualClass).combatarmor.max = Val(Text6(1).Text)
        FileChanged = True
    End If
    If ClassTbl(ActualClass).combatarmor.normal <> Val(Text7(1).Text) Then
        ClassTbl(ActualClass).combatarmor.normal = Val(Text7(1).Text)
        FileChanged = True
    End If
    If ClassTbl(ActualClass).combatarmor.energy <> Val(Text8(1).Text) Then
        ClassTbl(ActualClass).combatarmor.energy = Val(Text8(1).Text)
        FileChanged = True
    End If
    If ClassTbl(ActualClass).bodyarmor.base <> Val(Text9(2).Text) Then
        ClassTbl(ActualClass).bodyarmor.base = Val(Text9(2).Text)
        FileChanged = True
    End If
    If ClassTbl(ActualClass).bodyarmor.max <> Val(Text10(2).Text) Then
        ClassTbl(ActualClass).bodyarmor.max = Val(Text10(2).Text)
        FileChanged = True
    End If
    If ClassTbl(ActualClass).bodyarmor.normal <> Val(Text11(2).Text) Then
        ClassTbl(ActualClass).bodyarmor.normal = Val(Text11(2).Text)
        FileChanged = True
    End If
    If ClassTbl(ActualClass).bodyarmor.energy <> Val(Text12(2).Text) Then
        ClassTbl(ActualClass).bodyarmor.energy = Val(Text12(2).Text)
        FileChanged = True
    End If
    Command2_Click
End Sub

Private Sub Command2_Click()
    Me.Hide
End Sub

Private Sub Form_Load()
    Rem res
End Sub

Private Sub Form_Terminate()
    Command2_Click
End Sub

Private Sub Form_Unload(Cancel As Integer)
    MainForm.Enabled = True
    OneClassForm.Enabled = True
End Sub
