#!/usr/bin/tcsh
set break_period=2700 ;#seconds
while ( 1 )
  zenity --width 1000 --height 500 \
  --question --title="Hi! I am your body" \
  --text="Can you please rest me for sometime?"
  set answer=$? ;#user answer clicked on the dialog box
  if ( $answer == 0 ) then
    sleep $break_period
  else
    exit
  endif
end
