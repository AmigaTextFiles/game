VERSION 5.00
Begin VB.Form Form3 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Wyrm RWS File"
   ClientHeight    =   4320
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6135
   Icon            =   "Form3.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   4320
   ScaleWidth      =   6135
   Begin VB.CommandButton Command4 
      Caption         =   "Close"
      Height          =   615
      Left            =   3960
      TabIndex        =   7
      Top             =   3600
      Width           =   735
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Save as"
      Height          =   615
      Left            =   3120
      TabIndex        =   6
      Top             =   3600
      Width           =   735
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Save"
      Enabled         =   0   'False
      Height          =   615
      Left            =   2280
      TabIndex        =   5
      Top             =   3600
      Width           =   735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Open"
      Height          =   615
      Left            =   1440
      TabIndex        =   4
      Top             =   3600
      Width           =   735
   End
   Begin VB.Frame Frame2 
      Caption         =   "Types"
      Height          =   735
      Left            =   4080
      TabIndex        =   2
      Top             =   120
      Width           =   1815
      Begin VB.ComboBox Types 
         Height          =   315
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   240
         Width           =   1335
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Items"
      Height          =   735
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   3615
      Begin VB.ComboBox Items 
         Height          =   315
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   240
         Width           =   3135
      End
   End
   Begin VB.Frame Frame10 
      Caption         =   "Upgrade"
      Enabled         =   0   'False
      Height          =   2535
      Left            =   240
      TabIndex        =   39
      Top             =   960
      Visible         =   0   'False
      Width           =   5655
      Begin VB.ListBox List5 
         Height          =   1230
         Left            =   1320
         TabIndex        =   42
         Top             =   1080
         Width           =   3255
      End
      Begin VB.CommandButton Command13 
         Caption         =   "Remove"
         Height          =   255
         Left            =   4680
         TabIndex        =   40
         Top             =   1680
         Width           =   855
      End
      Begin VB.CommandButton Command14 
         Caption         =   "Add"
         Height          =   255
         Left            =   4680
         TabIndex        =   41
         Top             =   1320
         Width           =   855
      End
      Begin VB.Label Label13 
         Alignment       =   2  'Center
         Caption         =   $"Form3.frx":058A
         Height          =   615
         Left            =   480
         TabIndex        =   44
         Top             =   240
         Width           =   4815
      End
      Begin VB.Label Label12 
         Caption         =   "List of items:"
         Height          =   255
         Left            =   360
         TabIndex        =   43
         Top             =   1560
         Width           =   975
      End
   End
   Begin VB.Frame Frame9 
      Caption         =   "Class"
      Enabled         =   0   'False
      Height          =   2535
      Left            =   240
      TabIndex        =   33
      Top             =   960
      Visible         =   0   'False
      Width           =   5655
      Begin VB.ListBox List4 
         Height          =   1230
         Left            =   1320
         TabIndex        =   36
         Top             =   1080
         Width           =   3255
      End
      Begin VB.CommandButton Command12 
         Caption         =   "Add"
         Height          =   255
         Left            =   4680
         TabIndex        =   35
         Top             =   1320
         Width           =   855
      End
      Begin VB.CommandButton Command11 
         Caption         =   "Remove"
         Height          =   255
         Left            =   4680
         TabIndex        =   34
         Top             =   1680
         Width           =   855
      End
      Begin VB.Label Label11 
         Alignment       =   2  'Center
         Caption         =   $"Form3.frx":063F
         Height          =   855
         Left            =   720
         TabIndex        =   38
         Top             =   240
         Width           =   4455
      End
      Begin VB.Label Label10 
         Caption         =   "List of items:"
         Height          =   255
         Left            =   360
         TabIndex        =   37
         Top             =   1560
         Width           =   975
      End
   End
   Begin VB.Frame Frame8 
      Caption         =   "Give"
      Enabled         =   0   'False
      Height          =   2535
      Left            =   240
      TabIndex        =   27
      Top             =   960
      Visible         =   0   'False
      Width           =   5655
      Begin VB.ListBox List3 
         Height          =   1230
         Left            =   1320
         TabIndex        =   30
         Top             =   1080
         Width           =   3255
      End
      Begin VB.CommandButton Command10 
         Caption         =   "Add"
         Height          =   255
         Left            =   4680
         TabIndex        =   29
         Top             =   1320
         Width           =   855
      End
      Begin VB.CommandButton Command9 
         Caption         =   "Remove"
         Height          =   255
         Left            =   4680
         TabIndex        =   28
         Top             =   1680
         Width           =   855
      End
      Begin VB.Label Label8 
         Caption         =   "List of items:"
         Height          =   255
         Left            =   360
         TabIndex        =   31
         Top             =   1560
         Width           =   975
      End
      Begin VB.Label Label9 
         Alignment       =   2  'Center
         Caption         =   $"Form3.frx":0741
         Height          =   855
         Left            =   480
         TabIndex        =   32
         Top             =   240
         Width           =   4575
      End
   End
   Begin VB.Frame Frame7 
      Caption         =   "Cycle"
      Enabled         =   0   'False
      Height          =   2535
      Left            =   240
      TabIndex        =   21
      Top             =   960
      Visible         =   0   'False
      Width           =   5655
      Begin VB.ListBox List2 
         Height          =   1230
         Left            =   1320
         TabIndex        =   24
         Top             =   1080
         Width           =   3255
      End
      Begin VB.CommandButton Command8 
         Caption         =   "Add"
         Height          =   255
         Left            =   4680
         TabIndex        =   23
         Top             =   1320
         Width           =   855
      End
      Begin VB.CommandButton Command7 
         Caption         =   "Remove"
         Height          =   255
         Left            =   4680
         TabIndex        =   22
         Top             =   1680
         Width           =   855
      End
      Begin VB.Label Label7 
         Alignment       =   2  'Center
         Caption         =   $"Form3.frx":0825
         Height          =   855
         Left            =   720
         TabIndex        =   26
         Top             =   240
         Width           =   4455
      End
      Begin VB.Label Label6 
         Caption         =   "List of items:"
         Height          =   255
         Left            =   360
         TabIndex        =   25
         Top             =   1560
         Width           =   975
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "Random"
      Enabled         =   0   'False
      Height          =   2535
      Left            =   240
      TabIndex        =   15
      Top             =   960
      Visible         =   0   'False
      Width           =   5655
      Begin VB.CommandButton Command6 
         Caption         =   "Remove"
         Height          =   255
         Left            =   4680
         TabIndex        =   20
         Top             =   1680
         Width           =   855
      End
      Begin VB.CommandButton Command5 
         Caption         =   "Add"
         Height          =   255
         Left            =   4680
         TabIndex        =   19
         Top             =   1320
         Width           =   855
      End
      Begin VB.ListBox List1 
         Height          =   1230
         Left            =   1320
         TabIndex        =   17
         Top             =   1080
         Width           =   3255
      End
      Begin VB.Label Label5 
         Caption         =   "List of items:"
         Height          =   255
         Left            =   360
         TabIndex        =   18
         Top             =   1560
         Width           =   975
      End
      Begin VB.Label Label4 
         Alignment       =   2  'Center
         Caption         =   $"Form3.frx":091C
         Height          =   855
         Left            =   840
         TabIndex        =   16
         Top             =   240
         Width           =   4215
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Remove"
      Enabled         =   0   'False
      Height          =   2535
      Left            =   240
      TabIndex        =   12
      Top             =   960
      Visible         =   0   'False
      Width           =   5655
      Begin VB.Label Label3 
         Caption         =   "The item will be removed (no other options)."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   960
         TabIndex        =   14
         Top             =   1800
         Width           =   3855
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         Caption         =   $"Form3.frx":09F2
         Height          =   1215
         Left            =   840
         TabIndex        =   13
         Top             =   360
         Width           =   3975
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Fixed"
      Enabled         =   0   'False
      Height          =   2535
      Left            =   240
      TabIndex        =   8
      Top             =   960
      Visible         =   0   'False
      Width           =   5655
      Begin VB.Frame Frame4 
         Caption         =   "Fixed to Item"
         Height          =   735
         Left            =   1080
         TabIndex        =   10
         Top             =   1320
         Width           =   3615
         Begin VB.ComboBox Combo1 
            Height          =   315
            Left            =   240
            Style           =   2  'Dropdown List
            TabIndex        =   11
            Top             =   240
            Width           =   3135
         End
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         Caption         =   $"Form3.frx":0AFD
         Height          =   735
         Left            =   840
         TabIndex        =   9
         Top             =   480
         Width           =   4095
      End
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Id_RWSFile As Integer
Function ItemIndex(classname As String) As Integer
    Dim sortir As Boolean
    Dim count As Integer
    Dim realclassname As String
    
    sortir = False
    realclassname = LCase(Trim(classname))
    
    count = 0
    Do While (count <= NumItems - 1) And Not sortir
        If LCase(Trim(ItemList(count).classname)) = realclassname Then
            sortir = True
        Else
            count = count + 1
        End If
    Loop
    If sortir Then
        ItemIndex = count
    Else
        Rem no trobat, tornem primer element...
        ItemIndex = 0
    End If
End Function
Private Sub Load_RWS()
    Dim tempdatos As String
    Dim count As Integer
    On Error GoTo ErrHandler
    
    RWSChanged = False
    Command2.Enabled = False
    
    Combo1.Clear
    Items.Clear
    For count = 0 To NumItems - 1
        Items.AddItem ItemList(count).PickupName
        Combo1.AddItem ItemList(count).PickupName
    Next
    Items.ListIndex = -1
    Combo1.ListIndex = -1
    
    Types.Clear
    Types.AddItem "Fixed"
    Types.AddItem "Remove"
    Types.AddItem "Random"
    Types.AddItem "Cycle"
    Types.AddItem "Give"
    Types.AddItem "Class"
    Types.AddItem "Upgrade"
    Types.ListIndex = -1
    Types.Enabled = False
Rem standard ones...
    Frame3.Visible = False
    Frame5.Visible = False
    Frame6.Visible = False
    Frame7.Visible = False
    Frame8.Visible = False
    Frame9.Visible = False
    Frame10.Visible = False
    Frame3.Enabled = False
    Frame5.Enabled = False
    Frame6.Enabled = False
    Frame7.Enabled = False
    Frame8.Enabled = False
    Frame9.Enabled = False
    Frame10.Enabled = False
    
    Rem netejar RWSlist
    For count = 0 To NumItems - 1
        RWSLiSt(count).NumItems = 1
        Rem tots a fixed!
        RWSLiSt(count).Type = 0
        RWSLiSt(count).ItemList(0) = count
    Next
    
    If (RWS_File <> "") Then
        Id_RWSFile = FreeFile
        Open RWS_File For Input Access Read As #Id_RWSFile
        
        trobatinici = False
        llegitnombre = False
        llegittipus = False
        rwsactual = 0
        llegits = 0
        Do While Not EOF(1)
            Line Input #Id_RWSFile, entradadatos
            tempdatos = Trim(entradadatos)
            If (Left(tempdatos, 1) <> ";") Then
                If Not trobatinici Then
                    rwsactual = ItemIndex(tempdatos)
                    trobatinici = True
                    llegittipus = False
                    llegitnombre = False
                ElseIf Not llegittipus Then
                    llegittipus = True
                    Select Case tempdatos
                        Case "FIXED"
                            llegitnombre = True
                            RWSLiSt(rwsactual).NumItems = 1
                            RWSLiSt(rwsactual).Type = 0
                        Case "REMOVE"
                            llegitnombre = Trues
                            RWSLiSt(rwsactual).NumItems = 0
                            RWSLiSt(rwsactual).Type = 1
                        Case "RANDOM"
                            RWSLiSt(rwsactual).Type = 2
                        Case "CYCLE"
                            RWSLiSt(rwsactual).Type = 3
                        Case "GIVE"
                            RWSLiSt(rwsactual).Type = 4
                        Case "CLASS"
                            RWSLiSt(rwsactual).Type = 5
                        Case "UPGRADE"
                            RWSLiSt(rwsactual).Type = 6
                        Case Else
                            Rem fixed com a default... no fer res
                            llegitnombre = True
                            RWSLiSt(rwsactual).NumItems = 1
                            RWSLiSt(rwsactual).Type = 0
                    End Select
                ElseIf Not llegitnombre Then
                    RWSLiSt(rwsactual).NumItems = Val(tempdatos)
                    llegits = 0
                    llegitnombre = True
                ElseIf llegits < RWSLiSt(rwsactual).NumItems Then
                    Rem llegint items...
                    RWSLiSt(rwsactual).ItemList(llegits) = ItemIndex(tempdatos)
                    llegits = llegits + 1
                End If
            
                If llegits >= RWSLiSt(rwsactual).NumItems Then
                    Rem finalitzat. Reseteja variables...
                    trobatinici = False
                    llegitnombre = False
                    llegittipus = False
                    llegits = 0
                    rwsactual = 0
                End If
            End If
        Loop
        
        Close Id_RWSFile
    End If
Exit Sub
ErrHandler:
Rem camps netejats!
 Exit Sub
End Sub

Private Function Anterior() As Boolean
    Dim Seleccio As Integer
    
    Rem Mirar si filechanged... :P
    If (RWSChanged) Then
        Seleccio = MsgBox("The RWS File has changed. Do you want to keep the changes?", vbYesNoCancel, "Warning!")
        If Seleccio = vbYes Then
Rem             RWS_Save 0
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

Sub Command1_Click()
 On Error GoTo ErrHandler
 MainForm.CommonDialog1.filename = RWS_File
 MainForm.CommonDialog1.DialogTitle = "Open RWS File..."
 MainForm.CommonDialog1.Filter = "RWS file (*.rws)|*.rws|All (*.*)|*.*"
 MainForm.CommonDialog1.FilterIndex = 1
 MainForm.CommonDialog1.Flags = cdlOFNHideReadOnly
 Rem mainform.CommonDialog1.ShowOpen
 OpenCM
 If MainForm.CommonDialog1.filename <> "" And MainForm.CommonDialog1.filename <> RC_File Then
    New_RWS_File = MainForm.CommonDialog1.filename
    Form_Load
 End If
 Rem MainForm.Show
Exit Sub
ErrHandler:
 Rem MainForm.Show
 Exit Sub
End Sub

Private Sub Command10_Click()
    Load Form4
    Command9.Enabled = True
End Sub

Private Sub Command11_Click()
    If (List4.ListIndex > -1) Then
        index = List4.ListIndex
        Do While (index < RWSLiSt(Items.ListIndex).NumItems)
            RWSLiSt(Items.ListIndex).ItemList(index) = RWSLiSt(Items.ListIndex).ItemList(index + 1)
            index = index + 1
        Loop
        List4.RemoveItem (List4.ListIndex)
        RWSLiSt(Items.ListIndex).NumItems = RWSLiSt(Items.ListIndex).NumItems - 1
    
        If (List4.ListIndex <= -1) Then
            Command11.Enabled = False
        End If
        Command2.Enabled = True
        RWSChanged = True
    End If
    Items_Change
End Sub

Private Sub Command12_Click()
    Load Form4
    Command11.Enabled = True
End Sub

Private Sub Command13_Click()
    If (List5.ListIndex > -1) Then
        index = List5.ListIndex
        Do While (index < RWSLiSt(Items.ListIndex).NumItems)
            RWSLiSt(Items.ListIndex).ItemList(index) = RWSLiSt(Items.ListIndex).ItemList(index + 1)
            index = index + 1
        Loop
        List5.RemoveItem (List5.ListIndex)
        RWSLiSt(Items.ListIndex).NumItems = RWSLiSt(Items.ListIndex).NumItems - 1
    
        If (List5.ListIndex <= -1) Then
            Command13.Enabled = False
        End If
        Command2.Enabled = True
        RWSChanged = True
    End If
    Items_Change

End Sub

Private Sub Command14_Click()
    Load Form4
    Command13.Enabled = True
End Sub

Sub RWS_Save(index As Integer)
    Dim count As Integer
    Dim count2 As Integer
    Dim tipus As Integer
    
    Rem si no RWS_File, demana nom
    If RWS_File = "" Or index <> 0 Then
        Rem demanar nom fitxer
        On Error GoTo ErrHandler
        MainForm.CommonDialog1.filename = RWS_File
        MainForm.CommonDialog1.DialogTitle = "Save As..."
        MainForm.CommonDialog1.Filter = "RWS file (*.rws)|*.rws|All (*.*)|*.*"
        MainForm.CommonDialog1.FilterIndex = 1
        MainForm.CommonDialog1.Flags = cdlOFNHideReadOnly + cdlOFNPathMustExist + cdlOFNOverwritePrompt
        Rem MainForm.CommonDialog1.ShowSave
        SaveCM
        Rem mirar si existeix?
        RWS_File = MainForm.CommonDialog1.filename
        Rem MainForm.Show
    End If
    Command2.Enabled = False
    RWSChanged = False
    If RWS_File <> "" Then
        Id_RWSFile = FreeFile
        Open RWS_File For Output Access Write As #Id_RWSFile
        Print #Id_RWSFile, ";"
        Print #Id_RWSFile, ";File generated by Wyrm RWS Editor"
        Print #Id_RWSFile, ";"
        Rem escriure fitxer!!
        For count = 0 To NumItems - 1
            Rem mirem si l'hem d'escriure
            tipus = RWSLiSt(count).Type
            If ((tipus <> 0) Or (RWSLiSt(count).ItemList(0) <> count)) Then
                Print #Id_RWSFile, ItemList(count).classname
                If (tipus = 0) Then
                    Print #Id_RWSFile, "FIXED"
                    Print #Id_RWSFile, ItemList(RWSLiSt(count).ItemList(0)).classname
                ElseIf (tipus = 1) Then
                    Print #Id_RWSFile, "REMOVE"
                ElseIf (tipus = 2) Then
                    Print #Id_RWSFile, "RANDOM"
                    For count2 = 0 To RWSLiSt(count).NumItems - 1
                        Print #Id_RWSFile, ItemList(RWSLiSt(count).ItemList(count2)).classname
                    Next
                ElseIf (tipus = 3) Then
                    Print #Id_RWSFile, "CYCLE"
                    For count2 = 0 To RWSLiSt(count).NumItems - 1
                        Print #Id_RWSFile, ItemList(RWSLiSt(count).ItemList(count2)).classname
                    Next
                ElseIf (tipus = 4) Then
                    Print #Id_RWSFile, "GIVE"
                    For count2 = 0 To RWSLiSt(count).NumItems - 1
                        Print #Id_RWSFile, ItemList(RWSLiSt(count).ItemList(count2)).classname
                    Next
                ElseIf (tipus = 5) Then
                    Print #Id_RWSFile, "UPGRADE"
                    For count2 = 0 To RWSLiSt(count).NumItems - 1
                        Print #Id_RWSFile, ItemList(RWSLiSt(count).ItemList(count2)).classname
                    Next
                ElseIf (tipus = 6) Then
                    Print #Id_RWSFile, "CLASS"
                    For count2 = 0 To RWSLiSt(count).NumItems - 1
                        Print #Id_RWSFile, ItemList(RWSLiSt(count).ItemList(count2)).classname
                    Next
                End If
            End If
        Next
        
        Close Id_RWSFile
    End If
Exit Sub
ErrHandler:
  MainForm.Show
  Exit Sub
End Sub

Sub Command2_Click()
    RWS_Save 0
End Sub

Sub Command3_Click()
    RWS_Save 1
End Sub

Sub Command4_Click()
    Dim sortir As Boolean
    Dim Seleccio As Integer
    
    sortir = False
    
    If (RWSChanged) Then
        Seleccio = MsgBox("The RWS File has been changed. Do you want to keep the changes?", vbYesNoCancel, "Warning!")
        If Seleccio = vbYes Then
            RWS_Save 0
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
        Form3.Enabled = False
        RWS_Activated = False
        Unload Me
        MainForm.MenuRWS.Enabled = False
    End If
    MainForm.Show
End Sub

Private Sub Command5_Click()
    Load Form4
    Command6.Enabled = True
End Sub

Private Sub Command6_Click()
    If (List1.ListIndex > -1) Then
        index = List1.ListIndex
        Do While (index < RWSLiSt(Items.ListIndex).NumItems)
            RWSLiSt(Items.ListIndex).ItemList(index) = RWSLiSt(Items.ListIndex).ItemList(index + 1)
            index = index + 1
        Loop
        List1.RemoveItem (List1.ListIndex)
        RWSLiSt(Items.ListIndex).NumItems = RWSLiSt(Items.ListIndex).NumItems - 1
    
        If (List1.ListIndex <= -1) Then
            Command6.Enabled = False
        End If
        RWSChanged = True
        Command2.Enabled = True
    End If
    Items_Change
End Sub

Private Sub Command7_Click()
    If (List2.ListIndex > -1) Then
        index = List2.ListIndex
        Do While (index < RWSLiSt(Items.ListIndex).NumItems)
            RWSLiSt(Items.ListIndex).ItemList(index) = RWSLiSt(Items.ListIndex).ItemList(index + 1)
            index = index + 1
        Loop
        List2.RemoveItem (List2.ListIndex)
        RWSLiSt(Items.ListIndex).NumItems = RWSLiSt(Items.ListIndex).NumItems - 1
    
        If (List.ListIndex <= -1) Then
            Command7.Enabled = False
        End If
        RWSChanged = True
        Command2.Enabled = True
    End If
    Items_Change
End Sub

Private Sub Command8_Click()
    Load Form4
    Command7.Enabled = True
End Sub

Private Sub Command9_Click()
    If (List3.ListIndex > -1) Then
        index = List3.ListIndex
        Do While (index < RWSLiSt(Items.ListIndex).NumItems)
            RWSLiSt(Items.ListIndex).ItemList(index) = RWSLiSt(Items.ListIndex).ItemList(index + 1)
            index = index + 1
        Loop
        List3.RemoveItem (List3.ListIndex)
        RWSLiSt(Items.ListIndex).NumItems = RWSLiSt(Items.ListIndex).NumItems - 1
    
        If (List3.ListIndex <= -1) Then
            Command9.Enabled = False
        End If
        RWSChanged = True
        Command2.Enabled = True
    End If
    Items_Change
End Sub

Sub Form_Load()
    Dim retorn As Boolean
    retorn = False
    If RWS_Activated Then
        retorn = Anterior
    End If
    If Not retorn Then
        RWS_File = New_RWS_File
        Load_RWS
        RWS_Activated = True
        Enabled = True
        MainForm.MenuRWS.Enabled = True
    End If
End Sub

Private Sub Form_Terminate()
    If RWS_Activated Then
        Command4_Click
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    If RWS_Activated Then
        Command4_Click
    End If
End Sub

Sub Items_Change()
    Dim count As Integer
  Rem Amaga tots els frames...
    Frame3.Visible = False
    Frame5.Visible = False
    Frame6.Visible = False
    Frame7.Visible = False
    Frame8.Visible = False
    Frame9.Visible = False
    Frame10.Visible = False
    Frame3.Enabled = False
    Frame5.Enabled = False
    Frame6.Enabled = False
    Frame7.Enabled = False
    Frame8.Enabled = False
    Frame9.Enabled = False
    Frame10.Enabled = False
    Rem fes apareixer el corresponen...
    If Items.ListIndex > -1 Then
        Types.Enabled = True
        Types.ListIndex = RWSLiSt(Items.ListIndex).Type
    Else
        Types.Enabled = False
    End If
    
    Select Case Types.ListIndex
        Case 0
            Frame3.Visible = True
            Frame3.Enabled = True
            Rem Posa element 0 de la llista com a standard fixed.
            Combo1.ListIndex = RWSLiSt(Items.ListIndex).ItemList(0)
        Case 1
            Frame5.Visible = True
            Frame5.Enabled = True
            Rem remove... no mes opcions
        Case 2
            Frame6.Visible = True
            Frame6.Enabled = True
            Rem random
            List1.Clear
            For count = 0 To RWSLiSt(Items.ListIndex).NumItems - 1
                List1.AddItem ItemList(RWSLiSt(Items.ListIndex).ItemList(count)).PickupName
            Next
            List1.ListIndex = -1
            Command6.Enabled = False
        Case 3
            Frame7.Visible = True
            Frame7.Enabled = True
            Rem cycle
            List2.Clear
            For count = 0 To RWSLiSt(Items.ListIndex).NumItems - 1
                List2.AddItem ItemList(RWSLiSt(Items.ListIndex).ItemList(count)).PickupName
            Next
            List2.ListIndex = -1
            Command7.Enabled = False
        Case 4
            Frame8.Visible = True
            Frame8.Enabled = True
            Rem give
            List3.Clear
            For count = 0 To RWSLiSt(Items.ListIndex).NumItems - 1
                List3.AddItem ItemList(RWSLiSt(Items.ListIndex).ItemList(count)).PickupName
            Next
            List3.ListIndex = -1
            Command9.Enabled = False
        Case 5
            Frame9.Visible = True
            Frame9.Enabled = True
            Rem cycle
            List4.Clear
            For count = 0 To RWSLiSt(Items.ListIndex).NumItems - 1
                List4.AddItem ItemList(RWSLiSt(Items.ListIndex).ItemList(count)).PickupName
            Next
            List4.ListIndex = -1
            Command11.Enabled = False
        Case 6
            Frame10.Visible = True
            Frame10.Enabled = True
            Rem cycle
            List5.Clear
            For count = 0 To RWSLiSt(Items.ListIndex).NumItems - 1
                List5.AddItem ItemList(RWSLiSt(Items.ListIndex).ItemList(count)).PickupName
            Next
            List5.ListIndex = -1
            Command13.Enabled = False
    End Select

End Sub

Private Sub Items_Click()
    Items_Change
End Sub

Private Sub Items_KeyDown(KeyCode As Integer, Shift As Integer)
    Items_Change
End Sub
Private Sub Items_KeyUp(KeyCode As Integer, Shift As Integer)
    Items_Change
End Sub

Private Sub Items_Scroll()
    Items_Change
End Sub

Private Sub List1_Click()
    If List1.ListIndex > -1 Then
        Command6.Enabled = True
    End If
End Sub

Private Sub List2_Click()
    If List2.ListIndex > -1 Then
        Command7.Enabled = True
    End If
End Sub

Private Sub List3_Click()
    If List3.ListIndex > -1 Then
        Command9.Enabled = True
    End If
End Sub

Private Sub List4_Click()
    If List4.ListIndex > -1 Then
        Command11.Enabled = True
    End If
End Sub

Private Sub List5_Click()
    If (List5.ListIndex > -1) Then
        Command13.Enabled = True
    End If
End Sub

Private Sub Types_Change()
    RWSChanged = True
    Command2.Enabled = True
    RWSLiSt(Items.ListIndex).Type = Types.ListIndex
    Items_Change
End Sub

Private Sub Types_Click()
    RWSChanged = True
    Command2.Enabled = True

    RWSLiSt(Items.ListIndex).Type = Types.ListIndex
    Items_Change
End Sub

Private Sub Types_KeyDown(KeyCode As Integer, Shift As Integer)
    RWSChanged = True
    Command2.Enabled = True
    RWSLiSt(Items.ListIndex).Type = Types.ListIndex
    Items_Change
End Sub
Private Sub Types_KeyUp(KeyCode As Integer, Shift As Integer)
    RWSChanged = True
    Command2.Enabled = True
    RWSLiSt(Items.ListIndex).Type = Types.ListIndex
    Items_Change
End Sub

Private Sub Types_Scroll()
RWSChanged = True
Command2.Enabled = True
RWSLiSt(Items.ListIndex).Type = Types.ListIndex
Items_Change
End Sub
