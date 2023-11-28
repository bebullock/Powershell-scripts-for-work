Read-Host -Promt "Please ensure no other installers are running, if this is true press enter to continue"

curl "#Instert URL of needed RMM agent here#" -o c:\windows\temp\ #Name the file here remebering to add required file extention

#The above is the URL and the path to where the syncro installer is located, if you run into any issues

c:\windows\temp\ #input file name you used on line 3 after the output command --console --customerid  --folderid # <--- this is a Syncro specific line, if not using Sycnro everything after the file extention can be removed on this line

Read-Host -Prompt "Press enter to continue once Syncro install has completed"

curl "#Insert URL of needed RMM agent here" -o C:\windows\temp\ #Name the file here remebering to add required file extention

C:\windows\temp\ #Name the file here remebering to add required file extention from line 11