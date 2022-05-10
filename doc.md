To run: chmod +x ~/Desktop/myFolder/myscript.bash

Commands for files:
mkdir - Command to use to create a new directory
mv - Command to use move a file from one location to another
rm   - Command to use to remove/delete a file
rmdir - Command to use to remove/delete a directory
cat - Command to use to read the files
less - Command to use to read/view the longer files


Variables:
Named placeholders that refers to a certain value.
x=1 not x =  1
y="whatever one"
z='another variable'
$x or ${x} will return the value of x
variable1=$(Some Bash Command)

Conditions:
if <condition>; then

  <command(s)>

fi

if [ 5 -ge 4 ]; then

  echo "That number is greater than or equal to 4"

fi

to get the current user :> current_user=$(id -un)
