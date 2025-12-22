VERSION 5.00
Begin VB.Form OneClassForm 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Wyrm Class"
   ClientHeight    =   5835
   ClientLeft      =   3390
   ClientTop       =   1695
   ClientWidth     =   5760
   Icon            =   "OneClassForm.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5835
   ScaleWidth      =   5760
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton Command5 
      Caption         =   "Class Armors"
      Height          =   255
      Left            =   3360
      TabIndex        =   48
      Top             =   3840
      Width           =   1815
   End
   Begin VB.Frame Frame6 
      Caption         =   "Initial Weapon"
      Height          =   735
      Left            =   3240
      TabIndex        =   46
      Top             =   4200
      Width           =   2175
      Begin VB.ComboBox IniWeapon 
         Height          =   315
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   47
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Damage Resistances"
      Height          =   735
      Left            =   2880
      TabIndex        =   41
      Top             =   5040
      Width           =   2535
      Begin VB.TextBox Text2 
         Height          =   285
         Left            =   1920
         TabIndex        =   45
         Top             =   240
         Width           =   495
      End
      Begin VB.ComboBox DRes 
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   44
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Damage Enhancement"
      Height          =   735
      Left            =   120
      TabIndex        =   40
      Top             =   5040
      Width           =   2535
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   1920
         TabIndex        =   43
         Top             =   240
         Width           =   495
      End
      Begin VB.ComboBox DEnh 
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   42
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Edit"
      Enabled         =   0   'False
      Height          =   255
      Left            =   3720
      TabIndex        =   39
      Top             =   840
      Width           =   975
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Browse..."
      Height          =   255
      Left            =   2640
      TabIndex        =   38
      Top             =   840
      Width           =   975
   End
   Begin VB.Frame Frame3 
      Caption         =   "Initial Inventory"
      Height          =   735
      Left            =   120
      TabIndex        =   35
      Top             =   4200
      Width           =   2895
      Begin VB.ComboBox Inventory 
         Height          =   315
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   37
         Top             =   240
         Width           =   1815
      End
      Begin VB.TextBox Ammount 
         Height          =   285
         Left            =   2280
         TabIndex        =   36
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   4440
      TabIndex        =   34
      Top             =   240
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   3000
      TabIndex        =   33
      Top             =   240
      Width           =   1215
   End
   Begin VB.TextBox keys 
      Height          =   285
      Left            =   960
      TabIndex        =   32
      Top             =   840
      Width           =   1575
   End
   Begin VB.TextBox skin 
      Height          =   285
      Left            =   960
      TabIndex        =   30
      Top             =   480
      Width           =   1575
   End
   Begin VB.TextBox nameclass 
      Height          =   285
      Left            =   960
      TabIndex        =   28
      Text            =   "(Unnamed)"
      Top             =   120
      Width           =   1575
   End
   Begin VB.Frame Frame2 
      Caption         =   "Ammo Stats"
      Height          =   2535
      Left            =   2880
      TabIndex        =   14
      Top             =   1200
      Width           =   2655
      Begin VB.TextBox maxcells 
         Height          =   285
         Left            =   1560
         TabIndex        =   26
         Text            =   "200"
         Top             =   2160
         Width           =   615
      End
      Begin VB.TextBox maxslugs 
         Height          =   285
         Left            =   1560
         TabIndex        =   25
         Text            =   "50"
         Top             =   1800
         Width           =   615
      End
      Begin VB.TextBox maxrockets 
         Height          =   285
         Left            =   1560
         TabIndex        =   24
         Text            =   "50"
         Top             =   1440
         Width           =   615
      End
      Begin VB.TextBox maxgrenades 
         Height          =   285
         Left            =   1560
         TabIndex        =   23
         Text            =   "50"
         Top             =   1080
         Width           =   615
      End
      Begin VB.TextBox maxbullets 
         Height          =   285
         Left            =   1560
         TabIndex        =   22
         Text            =   "200"
         Top             =   720
         Width           =   615
      End
      Begin VB.TextBox maxshells 
         Height          =   285
         Left            =   1560
         TabIndex        =   21
         Text            =   "100"
         Top             =   360
         Width           =   615
      End
      Begin VB.Label Label12 
         Caption         =   "Max Shells"
         Height          =   255
         Left            =   240
         TabIndex        =   20
         Top             =   360
         Width           =   1335
      End
      Begin VB.Label Label11 
         Caption         =   "Max Bullets"
         Height          =   255
         Left            =   240
         TabIndex        =   19
         Top             =   720
         Width           =   1335
      End
      Begin VB.Label Label10 
         Caption         =   "Max Grenades"
         Height          =   255
         Left            =   240
         TabIndex        =   18
         Top             =   1080
         Width           =   1335
      End
      Begin VB.Label Label9 
         Caption         =   "Max Rockets"
         Height          =   255
         Left            =   240
         TabIndex        =   17
         Top             =   1440
         Width           =   1335
      End
      Begin VB.Label Label8 
         Caption         =   "Max Slugs"
         Height          =   255
         Left            =   240
         TabIndex        =   16
         Top             =   1800
         Width           =   1335
      End
      Begin VB.Label Label7 
         Caption         =   "Max Cells"
         Height          =   255
         Left            =   240
         TabIndex        =   15
         Top             =   2160
         Width           =   1335
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Basic Stats"
      Height          =   2895
      Left            =   120
      TabIndex        =   0
      Top             =   1200
      Width           =   2415
      Begin VB.TextBox knockback 
         Height          =   285
         Left            =   1440
         TabIndex        =   12
         Text            =   "1.000"
         Top             =   2280
         Width           =   615
      End
      Begin VB.TextBox resistance 
         Height          =   285
         Left            =   1440
         TabIndex        =   11
         Text            =   "1.000"
         Top             =   1920
         Width           =   615
      End
      Begin VB.TextBox power 
         Height          =   285
         Left            =   1440
         TabIndex        =   10
         Text            =   "1.000"
         Top             =   1560
         Width           =   615
      End
      Begin VB.TextBox speed 
         Height          =   285
         Left            =   1440
         TabIndex        =   9
         Text            =   "1.000"
         Top             =   1200
         Width           =   615
      End
      Begin VB.TextBox maxhealth 
         Height          =   285
         Left            =   1440
         TabIndex        =   8
         Text            =   "100"
         Top             =   840
         Width           =   615
      End
      Begin VB.TextBox health 
         Height          =   285
         Left            =   1440
         TabIndex        =   7
         Text            =   "100"
         Top             =   480
         Width           =   615
      End
      Begin VB.Label Label13 
         Caption         =   "Max Health"
         Height          =   255
         Left            =   360
         TabIndex        =   13
         Top             =   840
         Width           =   975
      End
      Begin VB.Label Label6 
         Caption         =   "Knockback"
         Height          =   255
         Left            =   360
         TabIndex        =   6
         Top             =   2280
         Width           =   1335
      End
      Begin VB.Label Label5 
         Caption         =   "Resistance"
         Height          =   255
         Left            =   360
         TabIndex        =   5
         Top             =   1920
         Width           =   1335
      End
      Begin VB.Label Label4 
         Caption         =   "Health"
         Height          =   255
         Left            =   360
         TabIndex        =   4
         Top             =   480
         Width           =   1335
      End
      Begin VB.Label Label1 
         Caption         =   "Power"
         Height          =   255
         Left            =   360
         TabIndex        =   3
         Top             =   1560
         Width           =   1335
      End
      Begin VB.Label Label3 
         Caption         =   "Speed"
         Height          =   255
         Left            =   360
         TabIndex        =   2
         Top             =   1200
         Width           =   1335
      End
      Begin VB.Label Label2 
         Caption         =   "Max Health"
         Height          =   255
         Left            =   1800
         TabIndex        =   1
         Top             =   2880
         Width           =   1335
      End
   End
   Begin VB.Label Label16 
      Caption         =   "Keys File"
      Height          =   255
      Left            =   120
      TabIndex        =   31
      Top             =   840
      Width           =   2295
   End
   Begin VB.Label Label15 
      Caption         =   "Skin"
      Height          =   255
      Left            =   480
      TabIndex        =   29
      Top             =   480
      Width           =   1815
   End
   Begin VB.Label Label14 
      Caption         =   "Name"
      Height          =   255
      Left            =   360
      TabIndex        =   27
      Top             =   120
      Width           =   1815
   End
End
Attribute VB_Name = "OneClassForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()
        Rem Retornar valors
        If ClassTbl(ActualClass).name <> OneClassForm.nameclass.Text Then
            Form1.ResetejaValorMenu ActualClass, OneClassForm.nameclass.Text
            ClassTbl(ActualClass).name = OneClassForm.nameclass.Text
            FileChanged = True
        End If
        
        
        If ClassTbl(ActualClass).skin <> OneClassForm.skin.Text Then
            ClassTbl(ActualClass).skin = OneClassForm.skin.Text
        End If
        If ClassTbl(ActualClass).keys <> OneClassForm.keys.Text Then
            ClassTbl(ActualClass).keys = OneClassForm.keys.Text
            FileChanged = True
        End If
        If ClassTbl(ActualClass).speed <> Val(OneClassForm.speed.Text) Then
            ClassTbl(ActualClass).speed = Val(OneClassForm.speed.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).power <> Val(OneClassForm.power.Text) Then
            ClassTbl(ActualClass).power = Val(OneClassForm.power.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).resistance <> Val(OneClassForm.resistance.Text) Then
            ClassTbl(ActualClass).resistance = Val(OneClassForm.resistance.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).knockback <> Val(OneClassForm.knockback.Text) Then
            ClassTbl(ActualClass).knockback = Val(OneClassForm.knockback.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).health <> Val(OneClassForm.health.Text) Then
            ClassTbl(ActualClass).health = Val(OneClassForm.health.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).maxhealth <> Val(OneClassForm.maxhealth.Text) Then
            ClassTbl(ActualClass).maxhealth = Val(OneClassForm.maxhealth.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).maxshells <> Val(OneClassForm.maxshells.Text) Then
            ClassTbl(ActualClass).maxshells = Val(OneClassForm.maxshells.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).maxbullets <> Val(OneClassForm.maxbullets.Text) Then
            ClassTbl(ActualClass).maxbullets = Val(OneClassForm.maxbullets.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).maxgrenades <> Val(OneClassForm.maxgrenades.Text) Then
            ClassTbl(ActualClass).maxgrenades = Val(OneClassForm.maxgrenades.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).maxrockets <> Val(OneClassForm.maxrockets.Text) Then
            ClassTbl(ActualClass).maxrockets = Val(OneClassForm.maxrockets.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).maxslugs <> Val(OneClassForm.maxslugs.Text) Then
            ClassTbl(ActualClass).maxslugs = Val(OneClassForm.maxslugs.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).maxcells <> Val(OneClassForm.maxcells.Text) Then
            ClassTbl(ActualClass).maxcells = Val(OneClassForm.maxcells.Text)
            FileChanged = True
        End If
        If ClassTbl(ActualClass).initial_weapon <> Val(OneClassForm.IniWeapon.ListIndex) Then
            ClassTbl(ActualClass).initial_weapon = Val(OneClassForm.IniWeapon.ListIndex)
            FileChanged = True
        End If
Rem     JA HEM MIRAT SI HAN CAMBIAT
Rem        If ActualJacket <> ClassTbl(List1.ListIndex).jacketarmor Then
Rem            ClassTbl(List1.ListIndex).jacketarmor = ActualJacket
Rem        End If
Rem        If ActualCombat <> ClassTbl(List1.ListIndex).combatarmor Then
Rem            ActualCombat = ClassTbl(List1.ListIndex).combatarmor
Rem        End If
Rem        If ActualBody <> ClassTbl(List1.ListIndex).bodyarmor Then
Rem            ActualBody = ClassTbl(List1.ListIndex).bodyarmor
Rem        End If
        
        For contador = 0 To NumItems - 1
            If AmmountList(contador) <> ClassTbl(ActualClass).Inventory(contador) Then
                ClassTbl(ActualClass).Inventory(contador) = AmmountList(contador)
                FileChanged = True
            End If
        Next
        For contador = 0 To NumMods - 1
            If InflictList(contador) <> ClassTbl(ActualClass).DEnh(contador) Then
                ClassTbl(ActualClass).DEnh(contador) = InflictList(contador)
                FileChanged = True
            End If
            If ResistanceList(contador) <> ClassTbl(ActualClass).DRes(contador) Then
                ClassTbl(ActualClass).DRes(contador) = ResistanceList(contador)
                FileChanged = True
            End If
        Next
        Rem Sortir
        Command2_Click
End Sub

Private Sub Command2_Click()
    Rem Sortir
    If FileChanged Then
        Form1.Command4.Enabled = True
    End If
    OneClassForm.Hide
    MainForm.Enabled = True
    MainForm.Show
End Sub

Private Sub Command3_Click()
 On Error GoTo ErrHandler
 MainForm.CommonDialog1.filename = ""
 MainForm.CommonDialog1.DialogTitle = "Choose Keys File"
 MainForm.CommonDialog1.Filter = "Keys file (*.keys)|*.keys|All (*.*)|*.*"
 MainForm.CommonDialog1.FilterIndex = 1
 MainForm.CommonDialog1.Flags = cdlOFNHideReadOnly
 Rem MainForm.CommonDialog1.ShowOpen
 OpenCM
 If (MainForm.CommonDialog1.filename <> "") Then
    Dim Llargada As Integer
    Llargada = Len(MainForm.CommonDialog1.filename)
    Do While Mid(MainForm.CommonDialog1.filename, Llargada, 1) <> "\" And Llargada > 0
        Llargada = Llargada - 1
    Loop
    If Llargada > 0 Then
        Llargada = Llargada - 1
    End If
    keys.Text = Right(MainForm.CommonDialog1.filename, Llargada)
 End If
Exit Sub
ErrHandler:
 Rem Res
 Exit Sub
End Sub


Private Sub Command5_Click()
    ActualJacket.base = ClassTbl(ActualClass).jacketarmor.base
    ActualJacket.max = ClassTbl(ActualClass).jacketarmor.max
    ActualJacket.normal = ClassTbl(ActualClass).jacketarmor.normal
    ActualJacket.energy = ClassTbl(ActualClass).jacketarmor.energy
    ActualCombat.base = ClassTbl(ActualClass).combatarmor.base
    ActualCombat.max = ClassTbl(ActualClass).combatarmor.max
    ActualCombat.normal = ClassTbl(ActualClass).combatarmor.normal
    ActualCombat.energy = ClassTbl(ActualClass).combatarmor.energy
    ActualBody.base = ClassTbl(ActualClass).bodyarmor.base
    ActualBody.max = ClassTbl(ActualClass).bodyarmor.max
    ActualBody.normal = ClassTbl(ActualClass).bodyarmor.normal
    ActualBody.energy = ClassTbl(ActualClass).bodyarmor.energy
    Load Form5
    
    Rem setejem alguns valors
    Form5.Text1(0).Text = Trim(Str(ActualJacket.base))
    Form5.Text2(0).Text = Trim(Str(ActualJacket.max))
    Form5.Text3(0).Text = Trim(Str(ActualJacket.normal))
    Form5.Text4(0).Text = Trim(Str(ActualJacket.energy))
    Form5.Text5(1).Text = Trim(Str(ActualCombat.base))
    Form5.Text6(1).Text = Trim(Str(ActualCombat.max))
    Form5.Text7(1).Text = Trim(Str(ActualCombat.normal))
    Form5.Text8(1).Text = Trim(Str(ActualCombat.energy))
    Form5.Text9(2).Text = Trim(Str(ActualBody.base))
    Form5.Text10(2).Text = Trim(Str(ActualBody.max))
    Form5.Text11(2).Text = Trim(Str(ActualBody.normal))
    Form5.Text12(2).Text = Trim(Str(ActualBody.energy))
    
    Form5.Show vbModal
End Sub

Private Sub DEnh_Click()
    If DEnh.ListIndex > -1 Then
        Text1.Enabled = True
        If (OldEnh > -1) Then
            InflictList(OldEnh) = Val(Text1.Text)
        End If
        Text1.Text = Trim(Str(InflictList(DEnh.ListIndex)))
        OldEnh = DEnh.ListIndex
    End If
End Sub
Private Sub DRes_Click()
    If DRes.ListIndex > -1 Then
        Text2.Enabled = True
        If (OldRes > -1) Then
            ResistanceList(OldRes) = Val(Text2.Text)
        End If
        Text2.Text = Trim(Str(ResistanceList(DRes.ListIndex)))
        OldRes = DRes.ListIndex
    End If
End Sub

Private Sub Form_Load()
    Dim count As Integer
    
    Inventory.Clear
    IniWeapon.Clear
    For count = 0 To NumItems - 1
        Inventory.AddItem ItemList(count).PickupName
    Next
    For count = 0 To NumWeapons - 1
        IniWeapon.AddItem ItemList(count).PickupName
    Next
    
    DRes.Clear
    DEnh.Clear
    For count = 0 To NumMods - 1
        DRes.AddItem ModList(count).name
        DEnh.AddItem ModList(count).name
    Next
End Sub

Private Sub Form_Terminate()
    Command2_Click
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Command2_Click
End Sub

Private Sub Inventory_Click()
    If Inventory.ListIndex > -1 Then
        Ammount.Enabled = True
        If (OldInventory > -1) Then
            AmmountList(OldInventory) = Val(Ammount.Text)
        End If
        Ammount.Text = Trim(Str(AmmountList(Inventory.ListIndex)))
        OldInventory = Inventory.ListIndex
    End If
End Sub

