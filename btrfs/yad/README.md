
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY <program>

mkfifo boo
echo -e "\f\nOne\Two\nThreee" > boo
tail -f boo|yad --list  --column="Name" --print-all
