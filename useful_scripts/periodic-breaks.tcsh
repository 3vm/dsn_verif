#!/usr/bin/tcsh
set break_period=2400 ;#seconds
while ( 1 )
  zenity --width 600 --height 600 \
  --question --title="Hi! I am your body" \
  --text="<big>Can you please rest me for sometime?</big>"
  set answer=$? ;#user answer clicked on the dialog box
  if ( $answer == 0 ) then
    sleep $break_period
  else
    exit
  endif
end
