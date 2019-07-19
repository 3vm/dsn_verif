'repetition period in min
RepPeriod = 15

Do While 1
  usersel = MsgBox("Will you rest me, your body? " & RepPeriod,1)
  If usersel = 2 Then
    MsgBox("Remember to restart. Bye")
    Exit Do
  End If
  Wscript.sleep RepPeriod*60*1000
Loop
