Attribute VB_Name = "Module1"
Type Armour
    base As Integer
    max As Integer
    normal As Double
    energy As Double
End Type

Type Classe
    name As String
    skin As String
    keys As String
    speed As Double
    power As Double
    resistance As Double
    knockback As Double
    health As Double
    maxhealth As Double
    maxshells As Double
    maxbullets As Double
    maxgrenades As Double
    maxrockets As Double
    maxslugs As Double
    maxcells As Double
    Inventory(100) As Integer
    initial_weapon  As Integer
    DEnh(80) As Double
    DRes(80) As Double
    jacketarmor As Armour
    combatarmor As Armour
    bodyarmor As Armour
End Type

Type ItemList_Type
    classname As String
    PickupName As String
End Type

Type RC_Type
    ClassActivated As Boolean
    ClassSkin As Boolean
    ClassKeys As Boolean
End Type

Type RWS_Type
    Type As Integer
    ItemList(100) As Integer
    NumItems As Integer
End Type

Type ModList_Type
    name As String
    realname As String
End Type

Public Class_File As String
Public New_Class_File As String
Public RWS_File As String
Public New_RWS_File As String
Public RC_File As String
Public New_RC_File As String
Public ClassTbl(32) As Classe
Public ActualClass As Integer
Public FileChanged As Boolean
Public RCChanged As Boolean
Public RWSChanged As Boolean
Public KeysChanged As Boolean
Public ItemFile As String
Public NumItems As Integer
Public NumWeapons As Integer
Public ItemList(80) As ItemList_Type
Public RWSLiSt(80) As RWS_Type
Public Class_Activated As Boolean
Public RC_Activated As Boolean
Public RWS_Activated As Boolean
Public Keys_Activated As Boolean
Public ModList(80) As ModList_Type
Public ModFile As String
Public NumMods As Integer
Public AmmountList(80) As Integer
Public InflictList(80) As Double
Public ResistanceList(80) As Double
Public ActualJacket As Armour
Public ActualCombat As Armour
Public ActualBody As Armour
Rem oneclassform vars
Public OldInventory As Integer
Public OldRes As Integer
Public OldEnh As Integer

Sub OpenCM()
    MainForm.CommonDialog1.ShowOpen
    MainForm.Show
End Sub
Sub SaveCM()
    MainForm.CommonDialog1.ShowSave
    MainForm.Show
End Sub

