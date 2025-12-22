VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Wyrm Class File Editor"
   ClientHeight    =   5175
   ClientLeft      =   2535
   ClientTop       =   2130
   ClientWidth     =   3210
   Enabled         =   0   'False
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   258.75
   ScaleMode       =   0  'Usuario
   ScaleWidth      =   160.5
   Begin VB.CommandButton Command6 
      Caption         =   "Open"
      Height          =   735
      Left            =   240
      TabIndex        =   6
      Top             =   4200
      Width           =   735
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Exit"
      Height          =   735
      Left            =   2160
      TabIndex        =   5
      Top             =   4200
      Width           =   735
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Save"
      Height          =   735
      Left            =   1200
      TabIndex        =   4
      Top             =   4200
      Width           =   735
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Delete"
      Height          =   735
      Left            =   2160
      TabIndex        =   3
      Top             =   3360
      Width           =   735
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Modify"
      Height          =   735
      Left            =   1200
      TabIndex        =   2
      Top             =   3360
      Width           =   735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "New"
      Height          =   735
      Left            =   240
      TabIndex        =   1
      Top             =   3360
      Width           =   735
   End
   Begin VB.ListBox List1 
      Height          =   2985
      Left            =   480
      TabIndex        =   0
      Top             =   120
      Width           =   2175
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Id_ClassFile As Integer
Dim NumClass As Integer

Private Sub Command1_Click()
Rem nova classe
    If NumClass < 32 Then
        List1.AddItem ("(Unnamed)")
        ClassTbl(NumClass).health = 100
        ClassTbl(NumClass).maxhealth = 100
        ClassTbl(NumClass).keys = "default.keys"
        ClassTbl(NumClass).name = ""
        ClassTbl(NumClass).skin = ""
        ClassTbl(NumClass).maxshells = 100
        ClassTbl(NumClass).maxbullets = 200
        ClassTbl(NumClass).maxgrenades = 50
        ClassTbl(NumClass).maxrockets = 50
        ClassTbl(NumClass).maxslugs = 50
        ClassTbl(NumClass).maxcells = 200
        ClassTbl(NumClass).speed = 1
        ClassTbl(NumClass).power = 1
        ClassTbl(NumClass).resistance = 1
        ClassTbl(NumClass).knockback = 1
        For contador = 0 To NumItems - 1
            ClassTbl(NumClass).Inventory(contador) = 0
        Next
        For contador = 0 To NumMods - 1
            ClassTbl(NumClass).DEnh(contador) = 1
            ClassTbl(NumClass).DRes(contador) = 1
        Next
        ClassTbl(NumClass).initial_weapon = Form3.ItemIndex("weapon_blaster")
        ClassTbl(NumClass).jacketarmor.base = 25
        ClassTbl(NumClass).jacketarmor.max = 50
        ClassTbl(NumClass).jacketarmor.normal = 0.3
        ClassTbl(NumClass).jacketarmor.energy = 0
        
        ClassTbl(NumClass).combatarmor.base = 50
        ClassTbl(NumClass).combatarmor.max = 100
        ClassTbl(NumClass).combatarmor.normal = 0.6
        ClassTbl(NumClass).combatarmor.energy = 0.3
        
        ClassTbl(NumClass).bodyarmor.base = 100
        ClassTbl(NumClass).bodyarmor.max = 200
        ClassTbl(NumClass).bodyarmor.normal = 0.8
        ClassTbl(NumClass).bodyarmor.energy = 0.6
        
        NumClass = NumClass + 1
        FileChanged = True
        Form1.Command4.Enabled = True
    End If
End Sub

Private Sub Command2_Click()
    List1_DblClick
End Sub

Private Sub Command3_Click()
    If (List1.ListIndex > -1) Then
        index = List1.ListIndex
        Do While (index < NumClass)
            ClassTbl(index) = ClassTbl(index + 1)
            index = index + 1
        Loop
        List1.RemoveItem (List1.ListIndex)
        NumClass = NumClass - 1
    
        If (List1.ListIndex <= -1) Then
            Command2.Enabled = False
            Command3.Enabled = False
        End If
        FileChanged = True
    End If
End Sub
    
Private Sub SaveClass(index As Integer)
    If Class_File = "" Or index <> 0 Then
        Rem demanar nom fitxer
        On Error GoTo ErrHandler
        MainForm.CommonDialog1.filename = Class_File
        MainForm.CommonDialog1.DialogTitle = "Save As..."
        MainForm.CommonDialog1.Filter = "Class file (*.class)|*.class|All (*.*)|*.*"
        MainForm.CommonDialog1.FilterIndex = 1
        MainForm.CommonDialog1.Flags = cdlOFNHideReadOnly + cdlOFNPathMustExist + cdlOFNOverwritePrompt
        SaveCM
        Rem CommonDialog1.ShowSave
        
        Rem mirar si existeix?
        Class_File = MainForm.CommonDialog1.filename
        Rem MainForm.Show
    End If
    If Class_File <> "" Then
        Rem gravar fitxer...
        Open Class_File For Output Access Write As #Id_ClassFile
        Print #Id_ClassFile, "//"
        Print #Id_ClassFile, "//File generated by Wyrm Class Maker"
        Print #Id_ClassFile, "//"
        
        
        For t = 0 To NumClass - 1
            Print #Id_ClassFile, "{"
            If ClassTbl(t).name <> "" Then
                Print #Id_ClassFile, "name "; ClassTbl(t).name
            End If
            If ClassTbl(t).skin <> "" Then
                Print #Id_ClassFile, "skin "; ClassTbl(t).skin
            End If
            If ClassTbl(t).keys <> "" Then
                Print #Id_ClassFile, "keys "; ClassTbl(t).keys
            End If
            If ClassTbl(t).health <> 100 Then
                Print #Id_ClassFile, "health "; Str(ClassTbl(t).health)
            End If
            If ClassTbl(t).maxhealth <> 100 Then
                Print #Id_ClassFile, "max_health "; Str(ClassTbl(t).maxhealth)
            End If
            If ClassTbl(t).speed <> 1 Then
                Print #Id_ClassFile, "speed "; Str(ClassTbl(t).speed)
            End If
            If ClassTbl(t).resistance <> 1 Then
                Print #Id_ClassFile, "resistance "; Str(ClassTbl(t).resistance)
            End If
            If ClassTbl(t).power <> 1 Then
                Print #Id_ClassFile, "power "; Str(ClassTbl(t).power)
            End If
            If ClassTbl(t).knockback <> 1 Then
                Print #Id_ClassFile, "knockback "; Str(ClassTbl(t).knockback)
            End If
            If ClassTbl(t).maxshells <> 100 Then
                Print #Id_ClassFile, "max_shells "; Str(ClassTbl(t).maxshells)
            End If
            If ClassTbl(t).maxbullets <> 200 Then
                Print #Id_ClassFile, "max_bullets "; Str(ClassTbl(t).maxbullets)
            End If
            If ClassTbl(t).maxgrenades <> 50 Then
                Print #Id_ClassFile, "max_grenades "; Str(ClassTbl(t).maxgrenades)
            End If
            If ClassTbl(t).maxrockets <> 50 Then
                Print #Id_ClassFile, "max_rockets "; Str(ClassTbl(t).maxrockets)
            End If
            If ClassTbl(t).maxslugs <> 50 Then
                Print #Id_ClassFile, "max_slugs "; Str(ClassTbl(t).maxslugs)
            End If
            If ClassTbl(t).maxcells <> 200 Then
                Print #Id_ClassFile, "max_cells "; Str(ClassTbl(t).maxcells)
            End If
            If ClassTbl(t).initial_weapon <> Form3.ItemIndex("weapon_blaster") Then
                Print #Id_ClassFile, "initial_weapon "; ItemList(ClassTbl(t).initial_weapon).classname
            End If
            Rem class armors
            If ClassTbl(t).jacketarmor.base <> 25 Then
                Print #Id_ClassFile, "jacketarmor b "; Str(ClassTbl(t).jacketarmor.base)
            End If
            If ClassTbl(t).jacketarmor.max <> 50 Then
                Print #Id_ClassFile, "jacketarmor m "; Str(ClassTbl(t).jacketarmor.max)
            End If
            If ClassTbl(t).jacketarmor.normal <> 0.3 Then
                Print #Id_ClassFile, "jacketarmor n "; Str(ClassTbl(t).jacketarmor.normal)
            End If
            If ClassTbl(t).jacketarmor.energy <> 0 Then
                Print #Id_ClassFile, "jacketarmor e "; Str(ClassTbl(t).jacketarmor.energy)
            End If
            
            If ClassTbl(t).combatarmor.base <> 50 Then
                Print #Id_ClassFile, "combatarmor b "; Str(ClassTbl(t).combatarmor.base)
            End If
            If ClassTbl(t).combatarmor.max <> 100 Then
                Print #Id_ClassFile, "combatarmor m "; Str(ClassTbl(t).combatarmor.max)
            End If
            If ClassTbl(t).combatarmor.normal <> 0.6 Then
                Print #Id_ClassFile, "combatarmor n "; Str(ClassTbl(t).combatarmor.normal)
            End If
            If ClassTbl(t).combatarmor.energy <> 0.3 Then
                Print #Id_ClassFile, "combatarmor e "; Str(ClassTbl(t).combatarmor.energy)
            End If
            If ClassTbl(t).bodyarmor.base <> 100 Then
                Print #Id_ClassFile, "bodyarmor b "; Str(ClassTbl(t).bodyarmor.base)
            End If
            If ClassTbl(t).bodyarmor.max <> 200 Then
                Print #Id_ClassFile, "bodyarmor m "; Str(ClassTbl(t).bodyarmor.max)
            End If
            If ClassTbl(t).bodyarmor.normal <> 0.8 Then
                Print #Id_ClassFile, "bodyarmor n "; Str(ClassTbl(t).bodyarmor.normal)
            End If
            If ClassTbl(t).bodyarmor.energy <> 0.6 Then
                Print #Id_ClassFile, "bodyarmor e "; Str(ClassTbl(t).bodyarmor.energy)
            End If
            
            For contador = 0 To NumItems - 1
                If ClassTbl(t).Inventory(contador) > 0 Then
                    Print #Id_ClassFile, ItemList(contador).classname; " "; ClassTbl(t).Inventory(contador)
                End If
            Next
            For contador = 0 To NumMods - 1
                If ClassTbl(t).DEnh(contador) <> 1 Then
                    Print #Id_ClassFile, ModList(contador).realname; " i "; ClassTbl(t).DEnh(contador)
                End If
                If ClassTbl(t).DRes(contador) <> 1 Then
                    Print #Id_ClassFile, ModList(contador).realname; " r "; ClassTbl(t).DRes(contador)
                End If
            Next
            Print #Id_ClassFile, "}"
        Next
        Close Id_ClassFile
        FileChanged = False
        Command4.Enabled = False
    End If
Exit Sub
ErrHandler:
 Rem MainForm.Show
 Exit Sub
End Sub
    

Private Sub Command4_Click()
    SaveClass 0
End Sub

Private Sub Command5_Click()
    Dim Seleccio As Integer
    Dim sortir As Boolean
    
    sortir = False
    
    Rem Mirar si filechanged... :P
    If (FileChanged) Then
        Seleccio = MsgBox("The Class File has changed. Do you want to keep the changes?", vbYesNoCancel, "Warning!")
        If Seleccio = vbYes Then
            Command4_Click
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
        Class_Activated = False
        Form1.Enabled = False
        Unload Me
        MainForm.Visible = True
        MainForm.MenuClass.Enabled = False
    End If
End Sub

Private Sub Command6_Click()
 On Error GoTo ErrHandler
 MainForm.CommonDialog1.filename = ""
 MainForm.CommonDialog1.DialogTitle = "Choose Class File"
 MainForm.CommonDialog1.Filter = "Class file (*.class)|*.class|All (*.*)|*.*"
 MainForm.CommonDialog1.FilterIndex = 1
 MainForm.CommonDialog1.Flags = cdlOFNHideReadOnly
 Rem CommonDialog1.ShowOpen
 OpenCM
 If MainForm.CommonDialog1.filename <> "" Then
    If FileChanged Then
        Anterior
    End If
    Class_File = MainForm.CommonDialog1.filename
    Class_Load
 End If
 MainForm.Show
Exit Sub
ErrHandler:
 MainForm.Show
 Exit Sub
End Sub
Private Sub Class_Load()
    On Error GoTo ErrHandler
    Command2.Enabled = False
    Command3.Enabled = False
    Command4.Enabled = False
    
    FileChanged = False
    
    NumClass = 0
    NameAddedToList = False
    List1.Clear
    If (Class_File <> "") Then
        Id_ClassFile = FreeFile
        Open Class_File For Input Access Read As #Id_ClassFile
        trobatinici = False
        Do While Not EOF(1)
            Line Input #Id_ClassFile, entradadatos
            If Left(entradadatos, 2) <> "//" Then
                If (Not trobatinici) Then
                    If Left(entradadatos, 1) = "{" Then
                        trobatinici = True
                        Rem Reseteja el registre
                        ClassTbl(NumClass).health = 100
                        ClassTbl(NumClass).maxhealth = 100
                        ClassTbl(NumClass).keys = "default.keys"
                        ClassTbl(NumClass).name = ""
                        ClassTbl(NumClass).skin = ""
                        ClassTbl(NumClass).maxshells = 100
                        ClassTbl(NumClass).maxbullets = 200
                        ClassTbl(NumClass).maxgrenades = 50
                        ClassTbl(NumClass).maxrockets = 50
                        ClassTbl(NumClass).maxslugs = 50
                        ClassTbl(NumClass).maxcells = 200
                        ClassTbl(NumClass).speed = 1
                        ClassTbl(NumClass).power = 1
                        ClassTbl(NumClass).resistance = 1
                        ClassTbl(NumClass).knockback = 1
                        For contador = 0 To NumItems - 1
                            ClassTbl(NumClass).Inventory(contador) = 0
                        Next
                        For contador = 0 To NumMods - 1
                            ClassTbl(NumClass).DEnh(contador) = 1
                            ClassTbl(NumClass).DRes(contador) = 1
                        Next
                        ClassTbl(NumClass).initial_weapon = Form3.ItemIndex("weapon_blaster")
                        ClassTbl(NumClass).jacketarmor.base = 25
                        ClassTbl(NumClass).jacketarmor.max = 50
                        ClassTbl(NumClass).jacketarmor.normal = 0.3
                        ClassTbl(NumClass).jacketarmor.energy = 0
        
                        ClassTbl(NumClass).combatarmor.base = 50
                        ClassTbl(NumClass).combatarmor.max = 100
                        ClassTbl(NumClass).combatarmor.normal = 0.6
                        ClassTbl(NumClass).combatarmor.energy = 0.3
        
                        ClassTbl(NumClass).bodyarmor.base = 100
                        ClassTbl(NumClass).bodyarmor.max = 200
                        ClassTbl(NumClass).bodyarmor.normal = 0.8
                        ClassTbl(NumClass).bodyarmor.energy = 0.6
                    End If
                Else
                    If Left(entradadatos, 1) = "}" Then
                        If Not NameAddedToList Then
                            List1.AddItem "(Unnamed)"
                        End If
                        NameAddedToList = False
                        trobatinici = False
                        NumClass = NumClass + 1
                    Else
                        Dim NomActual As String
                        Dim NumeroActual As String
                        Dim SegonNumeroActual As String
                        Dim PosString As Integer
                        Dim BuscaNumero As Boolean
                        Dim BuscaSegonNumero As Boolean
                        Dim StringTrobatInici As Boolean
                        Dim opcio As String
                        
                        NomActual = ""
                        NumeroActual = ""
                        SegonNumeroActual = ""
                        PosString = 0
                        BuscaNumero = False
                        BuscaSegonNumero = False
                        StringTrobatInici = False
                        
                        Do While PosString < Len(entradadatos)
                            If Not StringTrobatInici Then
                                If Mid(entradadatos, PosString + 1, 1) <> " " Then
                                    StringTrobatInici = True
                                End If
                            End If
                            If StringTrobatInici Then
                                If Mid(entradadatos, PosString + 1, 1) <> " " Then
                                    If Not BuscaNumero Then
                                        NomActual = NomActual + Mid(entradadatos, PosString + 1, 1)
                                    ElseIf Not BuscaSegonNumero Then
                                        NumeroActual = NumeroActual + Mid(entradadatos, PosString + 1, 1)
                                    Else
                                        SegonNumeroActual = SegonNumeroActual + Mid(entradadatos, PosString + 1, 1)
                                    End If
                                Else
                                    If Not BuscaNumero Then
                                        BuscaNumero = True
                                        StringTrobatInici = False
                                    ElseIf Not BuscaSegonNumero Then
                                        BuscaSegonNumero = True
                                        StringTrobatInici = False
                                    Else
                                        PosString = Len(entradadatos)
                                    End If
                                End If
                            End If
                            PosString = PosString + 1
                        Loop
                    
                        Select Case LCase(NomActual)
                        Case "name"
                            ClassTbl(NumClass).name = NumeroActual
                            List1.AddItem NumeroActual
                            NameAddedToList = True
                        Case "skin"
                            ClassTbl(NumClass).skin = NumeroActual
                        Case "health"
                            ClassTbl(NumClass).health = Val(NumeroActual)
                        Case "max_health"
                            ClassTbl(NumClass).maxhealth = Val(NumeroActual)
                        Case "speed"
                            ClassTbl(NumClass).speed = Val(NumeroActual)
                        Case "power"
                            ClassTbl(NumClass).power = Val(NumeroActual)
                        Case "resistance"
                            ClassTbl(NumClass).resistance = Val(NumeroActual)
                        Case "knockback"
                            ClassTbl(NumClass).knockback = Val(NumeroActual)
                        Case "max_bullets"
                            ClassTbl(NumClass).maxbullets = Val(NumeroActual)
                        Case "max_shells"
                            ClassTbl(NumClass).maxshells = Val(NumeroActual)
                        Case "max_grenades"
                            ClassTbl(NumClass).maxgrenades = Val(NumeroActual)
                        Case "max_rockets"
                            ClassTbl(NumClass).maxrockets = Val(NumeroActual)
                        Case "max_slugs"
                            ClassTbl(NumClass).maxslugs = Val(NumeroActual)
                        Case "max_cells"
                            ClassTbl(NumClass).maxcells = Val(NumeroActual)
                        Case "keys"
                            ClassTbl(NumClass).keys = NumeroActual
                        Case "jacketarmor"
                            opcio = LCase(Left(LTrim(NumeroActual), 1))
                            If opcio = "b" Then
                                ClassTbl(NumClass).jacketarmor.base = Val(SegonNumeroActual)
                            ElseIf opcio = "m" Then
                                ClassTbl(NumClass).jacketarmor.max = Val(SegonNumeroActual)
                            ElseIf opcio = "n" Then
                                ClassTbl(NumClass).jacketarmor.normal = Val(SegonNumeroActual)
                            ElseIf opcio = "e" Then
                                ClassTbl(NumClass).jacketarmor.energy = Val(SegonNumeroActual)
                            End If
                        Case "combatarmor"
                            opcio = LCase(Left(LTrim(NumeroActual), 1))
                            If opcio = "b" Then
                                ClassTbl(NumClass).combatarmor.base = Val(SegonNumeroActual)
                            ElseIf opcio = "m" Then
                                ClassTbl(NumClass).combatarmor.max = Val(SegonNumeroActual)
                            ElseIf opcio = "n" Then
                                ClassTbl(NumClass).combatarmor.normal = Val(SegonNumeroActual)
                            ElseIf opcio = "e" Then
                                ClassTbl(NumClass).combatarmor.energy = Val(SegonNumeroActual)
                            End If
                        Case "bodyarmor"
                            opcio = LCase(Left(LTrim(NumeroActual), 1))
                            If opcio = "b" Then
                                ClassTbl(NumClass).bodyarmor.base = Val(SegonNumeroActual)
                            ElseIf opcio = "m" Then
                                ClassTbl(NumClass).bodyarmor.max = Val(SegonNumeroActual)
                            ElseIf opcio = "n" Then
                                ClassTbl(NumClass).bodyarmor.normal = Val(SegonNumeroActual)
                            ElseIf opcio = "e" Then
                                ClassTbl(NumClass).bodyarmor.energy = Val(SegonNumeroActual)
                            End If
                        Case Else
                            For contador = 0 To NumItems - 1
                                If ItemList(contador).classname = NomActual Then
                                    ClassTbl(NumClass).Inventory(contador) = Val(NumeroActual)
                                End If
                            Next
                            opcio = LCase(Left(LTrim(NumeroActual), 1))
                            For contador = 0 To NumMods - 1
                                If ModList(contador).realname = NomActual Then
                                    If opcio = "i" Then
                                        ClassTbl(NumClass).DEnh(contador) = Val(SegonNumeroActual)
                                    ElseIf opcio = "r" Then
                                        ClassTbl(NumClass).DRes(contador) = Val(SegonNumeroActual)
                                    End If
                                End If
                            Next
                        End Select
                    End If
                End If
            End If
        Loop
        Close Id_ClassFile
    End If
Exit Sub
ErrHandler:
Rem numclass = 0 ;)
Exit Sub
End Sub
Private Function Anterior() As Boolean
    Dim Seleccio As Integer
    
    Rem Mirar si filechanged... :P
    If (FileChanged) Then
        Seleccio = MsgBox("The Class File has changed. Do you want to keep the changes?", vbYesNoCancel, "Warning!")
        If Seleccio = vbYes Then
            Command4_Click
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
    If Class_Activated Then
        retorn = Anterior
    End If
    If Not retorn Then
        Class_File = New_Class_File
        Class_Load
        Class_Activated = True
        Form1.Enabled = True
        MainForm.MenuClass.Enabled = True
    End If
End Sub

Sub Form_Terminate()
    If Class_Activated Then
        Command5_Click
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    If Class_Activated Then
        Command5_Click
    End If
End Sub

Private Sub List1_Click()
    If List1.ListIndex > -1 Then
        Command2.Enabled = True
        Command3.Enabled = True
    End If
End Sub

Private Sub List1_DblClick()
    If List1.ListIndex > -1 Then
        Load OneClassForm
        Rem passar parametres!
        OneClassForm.skin.Text = ClassTbl(List1.ListIndex).skin
        OneClassForm.nameclass.Text = ClassTbl(List1.ListIndex).name
        OneClassForm.keys.Text = ClassTbl(List1.ListIndex).keys
        OneClassForm.speed.Text = Trim(Str(ClassTbl(List1.ListIndex).speed))
        OneClassForm.power.Text = Trim(Str(ClassTbl(List1.ListIndex).power))
        OneClassForm.resistance.Text = Trim(Str(ClassTbl(List1.ListIndex).resistance))
        OneClassForm.knockback.Text = Trim(Str(ClassTbl(List1.ListIndex).knockback))
        OneClassForm.health.Text = Trim(Str(ClassTbl(List1.ListIndex).health))
        OneClassForm.maxhealth.Text = Trim(Str(ClassTbl(List1.ListIndex).maxhealth))
        OneClassForm.maxshells.Text = Trim(Str(ClassTbl(List1.ListIndex).maxshells))
        OneClassForm.maxbullets.Text = Trim(Str(ClassTbl(List1.ListIndex).maxbullets))
        OneClassForm.maxgrenades.Text = Trim(Str(ClassTbl(List1.ListIndex).maxgrenades))
        OneClassForm.maxrockets.Text = Trim(Str(ClassTbl(List1.ListIndex).maxrockets))
        OneClassForm.maxslugs.Text = Trim(Str(ClassTbl(List1.ListIndex).maxslugs))
        OneClassForm.maxcells.Text = Trim(Str(ClassTbl(List1.ListIndex).maxcells))
        OneClassForm.IniWeapon.ListIndex = ClassTbl(List1.ListIndex).initial_weapon
        
        Rem passem armadura
        ActualJacket = ClassTbl(List1.ListIndex).jacketarmor
        ActualCombat = ClassTbl(List1.ListIndex).combatarmor
        ActualBody = ClassTbl(List1.ListIndex).bodyarmor
        
        For contador = 0 To NumItems - 1
            AmmountList(contador) = ClassTbl(List1.ListIndex).Inventory(contador)
        Next
        For contador = 0 To NumMods - 1
            InflictList(contador) = ClassTbl(List1.ListIndex).DEnh(contador)
            ResistanceList(contador) = ClassTbl(List1.ListIndex).DRes(contador)
        Next
        Rem passar classe
        ActualClass = List1.ListIndex
        
        Rem ressetejar alguns valors
        OneClassForm.Inventory.ListIndex = -1
        OneClassForm.IniWeapon.ListIndex = -1
        
        OldInventory = -1
        OldEnh = -1
        OldRes = -1
        
        OneClassForm.DRes.ListIndex = -1
        OneClassForm.DEnh.ListIndex = -1
        OneClassForm.Ammount.Enabled = False
        OneClassForm.Text1.Enabled = False
        OneClassForm.Text2.Enabled = False

        OneClassForm.Show vbModal
    End If
End Sub

Sub MenuExit_Click()
    Command5_Click
End Sub

Sub MenuSave_Click()
    SaveClass 0
End Sub

Sub MenuSaveAs_Click()
    SaveClass 1
End Sub

Sub OpenFile_Click()
    Command6_Click
End Sub

Sub ResetejaValorMenu(Posicio As Integer, Texte As String)
    List1.RemoveItem (Posicio)
    List1.AddItem Texte, Posicio
End Sub
