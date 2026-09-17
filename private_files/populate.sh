#!/bin/sh
# Builds the OMNI CTF forensics volume. Run inside Haiku.
# usage: populate.sh /path/to/mounted/bfs/volume
V="$1"
[ -d "$V" ] || { echo "ERROR: '$V' is not a directory"; exit 1; }
cd "$V" || exit 1

echo "### creating file contents (no flag in any body) ###"
printf 'Grocery run tomorrow: milk, bread, coffee.\n'            > notes_01.txt
printf 'Reminder: call the office about the printer.\n'          > notes_02.txt
printf 'Quarterly report draft. Numbers pending review.\n'       > report.txt
printf '[general]\nverbose=0\nretries=3\ntimeout=30\n'           > config.dat
printf 'IMG_0421.jpg   3024x4032   f/1.8   1/120s   ISO200\n'    > photo_meta.txt
printf 'Last backup completed OK. Details kept as metadata.\n'   > backup_note.txt
printf -- '- water the plants\n- renew the domain\n- pay rent\n' > todo.txt
printf 'This volume holds personal files. Nothing special.\n'    > readme.txt
printf 'You really thought it would be that easy?\n'             > secret.txt
: > contact.person

echo "### writing BFS attributes ###"
addattr -t string Meta:note    'T0RvOiBidXkgbWlsayE='                          notes_01.txt
addattr -t string Meta:note    'aGVsbG8gd29ybGQ='                              notes_02.txt
addattr -t string Meta:author  'admin'                                         report.txt
addattr -t string Sys:version  '1.2.3'                                         config.dat
addattr -t string Media:tag    'vacation'                                      photo_meta.txt
addattr -t string Meta:data    'ZmFrZV9mbGFnX2hlcmU='                          backup_note.txt
addattr -t string Meta:note    'cmVtaW5kZXI='                                  todo.txt
addattr -t string Doc:info     'nothing here'                                  readme.txt
addattr -t string Meta:hint    'keep looking'                                  secret.txt

# contact.person: looks like an ordinary Haiku People contact...
addattr -t string META:name    'Jonathan Reeve'                                contact.person
addattr -t string META:nickname 'jon'                                          contact.person
addattr -t string META:company 'Northwind Logistics'                           contact.person
addattr -t string META:email   'j.reeve@northwind-logistics.example'           contact.person
addattr -t string META:hphone  '+40 21 555 0142'                               contact.person
addattr -t string META:city    'Bucharest'                                     contact.person
addattr -t string META:country 'Romania'                                       contact.person
addattr -t string META:group   'Work'                                          contact.person
# ...but carries one extra attribute it should not have:
addattr -t string OMNI:flag    'T01OSUNURntoZWxsb19mcjBtX1RoM19XMHJsZDEhISF9'  contact.person

# make it show up as a real People contact in Haiku
settype -t application/x-person contact.person 2>/dev/null || \
  addattr -t mime BEOS:TYPE application/x-person contact.person

sync
echo "### DONE building ###"
