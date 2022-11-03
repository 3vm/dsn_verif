#dd if=USA-anthem.wav iflag=count_bytes count=42 of=t.wav
dd iflag=count_bytes if=$1 of=$2 count=$3
