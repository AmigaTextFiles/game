VERSION 5.00
Begin VB.Form Form4 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Add Item"
   ClientHeight    =   1305
   ClientLeft      =   4575
   ClientTop       =   4155
   ClientWidth     =   2925
   Icon            =   "Form4.frx":0000
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1305
   ScaleWidth      =   2925
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   1560
      TabIndex        =   3
      Top             =   840
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   840
      Width           =   1215
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   360
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   360
      Width           =   2175
   End
   Begin VB.Label Label1 
      Caption         =   "Choose the item you want to add..."
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   2535
   End
End
Attribute VB_Name = "Form4"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    If Combo1.ListIndex > -1 Then
        RWSLiSt(Form3.Items.ListIndex).ItemList(RWSLiSt(Form3.Items.ListIndex).NumItems) = Combo1.ListIndex
        RWSLiSt(Form3.Items.ListIndex).NumItems = RWSLiSt(Form3.Items.ListIndex).NumItems + 1
        RWSChanged = True
        Form3.Command2.Enabled = True
    End If
    Unload Me
End Sub
Private Sub Command2_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    Dim count As Integer
    Combo1.Clear
    For count = 0 To NumItems - 1
        Combo1.AddItem ItemList(count).PickupName
    Next
    Combo1.ListIndex = -1
    Form4.Show vbModal
End Sub

Private Sub Form_Terminate()
    Unload Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
    MainForm.Enabled = True
    Form3.Items_Change
End Sub

