#!/bin/bash 
	#----- for debugging use:  #!/bin/bash -xev
	#................ #! is call shebang  this means call /bin/bash <filename>
	#......... without this line, we execute our current shell (i.e cshell or kshell,..etc)
	# http://blogs.perl.org/users/buddy_burden/2012/04/perl-vs-shell-scripts.html
	# https://www.tldp.org/LDP/abs/html/sample-bashrc.html  for example of .bashrc
	# https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
	# https://www.cyberciti.biz/tips/bash-shell-parameter-substitution-2.html	# good example of expansions
	# http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_01.html  # reg exp meta characters (. ? *,..etc)
	#
echo "hello"   # or   echo 'hello' anything between single quotes is not interpreted

	#-- chomd 755 test.sh    # r = 4, w = 2, x = 1 : 755 means rwx for owner and rx for group and other users
	#-- ls -lart test.sh
	#-- -rwxr-xr-x 1 SJG 197121 309 Aug 26 08:20 test.sh*

	#-- $type echo	this will show if echo is a build-in shell command   -a mean all
	#-- echo is a shell builtin

	#-- $ type -a echo	# shows all instances on echo on our system
	#-- echo is a shell builtin
	#-- echo is /usr/bin/echo  # can use /ur/bin/echo 'hello'
	#-- echo is /bin/echo
	#-- echo is /usr/bin/echo

	#-- uptime    this is not a built-in script. use 'man uptime' to see help. 'help uptime doesn't work as it is not built-in'
# [ -e filepath ] Returns true if file exists.
# [ -x filepath ] Returns true if file exists and executable.
# [ -S filepath ] Returns true if file exists and its a socket file.
# [ expr1 -a expr2 ] Returns true if both the expression is true.
# [ expr1 -o expr2 ] Returns true if either of the expression1 or 2 is true.
# if [ -n "${SSH_CONNECTION}" ]		# if string length is not zero
# if [ -z "${SSH_CONNECTION}" ]		# if string length is zero
# if [[ "${DISPLAY%%:0*}" != "" ]]
# if [[ ${USER} == "root" ]]
# if [ -r /tmp/myfile.txt ]		# file has read permission
# if [ -w /tmp/myfile.txt ]		# file has write permission
# if [ -x /tmp/myfile.txt ]		# file has execute permission
# ls -l | awk 'BEGIN { print "Files found:\n" } /\<[a|x].*\.conf$/ { print $9 }'  # "Files found" is only printed once (not for every file)
# seq 5 | awk 'BEGIN{print "Hello"} /4/ {print $1}' 
# seq 5 | awk 'BEGIN{print "Hello"} /4/ {print}'	# as above 
# seq 5 | awk 'BEGIN{print "======\nHello"} /4/ {print $1} END{print "======="}' 
#
# command df -P "$PWD" | awk 'END {print $5} {sub(/%/,"")}'	# this gives  81  from output below
#     Filesystem     1024-blocks      Used Available Capacity Mounted on
#     C:               187695100 150703560  36991540      81% /c
#
# jobs -s	#restrict output to stopped jobs
# jobs -r	# restrict output to running jobs
#
# w		# shows list of users and what they r doing
#
# set -- 1 2 3 		# The set command (when not setting options) sets the positional parameters eg
#  echo $1 $2 $3	# this give u 1, 2 and 3
#
# NCPU=$(grep -c 'processor' /proc/cpuinfo)    # Number of CPUs
# SLOAD=$(( 100*${NCPU} ))        # Small load
# local SYSLOAD=$(cut -d " " -f1 /proc/loadavg | tr -d '.')  # tr changes 0.00 to 000  (deletes .)
# -------------------- functio to return a value
#function load()
#{
#    local SYSLOAD=$(cut -d " " -f1 /proc/loadavg | tr -d '.')
#    # System load of the current host.
#    echo $((10#$SYSLOAD))       # Convert to decimal.
#}
#
## Returns a color indicating system load.
#function load_color()
#{
#    local SYSLOAD=$(load)     			# set var to return value of function
#    if [ ${SYSLOAD} -gt ${SLOAD} ]; then
#
#
#
#
#--------------------- use of trap to call a cleanup function and exit
#function _exit()              # Function to run upon exit of shell.
#{
#    echo -e "${BRed}Hasta la vista, baby${NC}"
#}
#trap _exit EXIT
#------------------------------------------------------------
#
WORD='script'	#this is a variable.  there should be no spaces
echo "$WORD"    # use double quotes to interpret '$'
echo '$WORD'

echo "this is ${WORD}ing"

ENDING='ed'

echo "this is ${WORD}${ENDING}."

echo "your UID is ${UID} EUID is ${EUID}"	# $UID  is set bash    use 'man UID' to see what it is

#USER_NAME2=`id -un`	# same as below line (this is older version)
USER_NAME=$(id -un)	#USER_NAME will be set to output of command 'id -un'  , -un mean username
if [[ "${?}" -ne 0 ]]   # ${?} is the status of last command
then
	echo 'the command failed'
	#exit 1
fi

echo "Your username is ${USER_NAME}   username2 = $USER_NAME2"

#if [[ "${UID}" -eq 0 ]]   #---- must use spaces around '[[' and '[['  - this syntax would work in csh
if [ "${UID}" -eq 0 ]      #----as above (older style)
then
	echo ' you are root'
else
	echo 'you are not root'
fi
	# sudo ./test.sh    this means test.sh is executed as root
	# su    this will take you to root user shell (have to enter password)

UID_TO_TEST='1000'
if [[ "${UID}" -ne "${UID_TO_TEST}" ]]
then
	echo "your Id doesn't matc ${UID_TO_TEST}"
else
	echo "your id matches ${UID_TO_TEST}"
fi

USER_NAME_TO_TEST='vagrant'
#if [[ "${USERNAME}" = "${USER_NAME_TO_TEST}" ]]
#if [[ "${USERNAME}" == "${USER_NAME_TO_TEST}" ]] #-- '==' means string on the right hand side is used as a pattern and pattern matching is performed
if [[ "${USERNAME}" != "${USER_NAME_TO_TEST}" ]]
then
	echo "${USERNAME} matches ${USER_NAME_TO_TEST}"
else
	echo "${USERNAME} doesn't matches ${USER_NAME_TO_TEST}"
fi

#------------------------------------- unix commands
# cut -c 1 x.txt	# to cut the first char
# cut -c 7 x.txt	# to cut the 7th char
# cut -c 4-7 x.txt	# to cut the char 4 to 7
# cut -c 4- x.txt	# to cut the 4th to end 
# cut -c -4 x.txt	# to cut the first to 4th char
# cut -c 1-4 x.txt	# as above
# cut -c 1,3,5 x.txt	# to cut the first, 3th and 5th
# cut -c -999 x.txt	# to cut the 999th char. u get a blank line if does not exits

# cut -b -1 x.txt	# to cut the first byte
# cut -f -1 x.txt	# to cut the first field, defuakt field delimited is tab
# cut -d ',' -f -1 x.txt	# to cut the first field
# cut -d , -f -1 x.txt	# as above
# cut -d, -f -1 x.txt	# as above
# cut -d ':' -f 1,3,5 x.txt	
# cut -d ':' -f 1,3 --output-delimiter=',' x.txt   # in output we see , instead of :	
# cut -d '\' -f 3 x.txt
# grep first x.txt 	# let assume this file has a header of 'first,last' and some records have fields like 'firstly'
# grep 'first,last' x.txt	# to select header
# grep '^first' x.txt		# regexp: to select lines starting with first
# grep 't$' x.txt		# regexp: to select lines ending with t
# grep '^first,last$' x.txt	# to select header only using regexp
# grep -v '^first,last$' x.txt	# to exclude header using regexp
# grep -v '^first,last$' x.txt	| cut -d ',' -f 1
# cut -d ',' -f 1 x.txt | grep -v '^first$'	# as above but above is better
# cut -d 'DATA:' -f 2 x.tx	# this won't work. CUT ONLY WORKS WITH SINGLE CHAR DELIMITER
# awk -F 'DATA:' '{print $2}' x.txt	# use awk if delimiter is multi char , -F means field seperator
                                        # sample line: DATA:firstDATA:last
					# {} means take actions. {print $2} means print col2 
# cut -d ':' -f 1,3 x.txt	# this displays the ':' in output
# cut -d ':' -f 3,1 x.txt	# as above. cut displays the cols in order that they appear in the file
# awk -F ':' '{print $1, print $3}' x.txt	#as above but fields are seperated by space in output
					# ',' means output field seperator. by default it is white space (space of tab
# awk -F ':' '{print $1 $3}' x.txt	#as above but fields are stuck together (no space between them
# awk -F ':' -v OFS=',' '{print $1, $3}' x.txt	# to change space seperator to ','. OFS means output field seperator
# awk -F ':' -v OFS=',' '{print $1, $3}' x.txt	# to change space seperator to ','. OFS means output field seperator
# awk -F ':' '{print $1 "," $3}' x.txt			# as above
# awk -F ':' '{print $1 ", " $3}' x.txt			# as above with a space after comma
# awk -F ':' '{print "COL1: " $1 " COL3: " $3}' x.txt	# some text before cols
# awk -F ':' -v OFS=',' '{print $1    ,    $3}' x.txt	# spaces withing {} don't make a diff
# awk -F ':' -v OFS=',' '{print $3    ,    $1}' x.txt	# reverse the order of fields
# awk -F ':' '{print $NF, $(NF-1)}' x.txt	# NF means No. of field. print last field and the one to last
						# u can do math inside a brackets (i.e (NF - 1)
# netstat -n		# Displays protocol statistics and current TCP/IP network connections
# netstat -nutl		# u = udp   t = tcp   l = listening port
# netstat -nt | grep -Ev '^Active|^  Proto'	# E means Extended regexp. to exclude lines starting with Active or '  Proto'
# netstat -nt | grep ':' | awk '{print $2}' | awk -F ':' '{print $NF}'   # to get the port number
# netstat -nt | grep ':' | awk '{print $2}' | awk -F ':' '{print $NF}' | sort -nu  # sorted and duplicated removed
# netstat -nt | grep ':' | awk '{print $2}' | awk -F ':' '{print $NF}' | sort -n | uniq  # sorted and duplicated removed. uniq only works with a sorted list
# netstat -nt | grep ':' | awk '{print $2}' | awk -F ':' '{print $NF}' | sort -n | uniq -c #  shows the no. of dupl0icates
# netstat -nt | grep ':' | awk '{print $2}' | awk -F ':' '{print $NF}' | sort -n | uniq -c | tail -3  # print the last 3 
# geoiplookup 182.100.67.59	# gives location of an ip address (sample output:"GeoIp Country Edition CN, China"0
# sudo cat /var/log/messages | awk '{print $5}' | sort | uniq -c | sort	# shows no. of messages by system name
# wc temp.txt	# output is = "2  2 33 temp.txt". first col is no. of lines, 2nd col is no. of words, 3th col is no. of chars00 
# wc temp.txt -w	# only word count
# wc temp.txt -c	# only byte/char count
# wc temp.txt -l	# only line count
# grep bash /etc/passwd | wc -l
# grep -c bash /etc/passwd	# as above. grep can count as well 
# find . -type f -iname "*.php"
# find . -type f -not -iname "*.php"	# not *.php file
# find . -maxdepth 2 -type f -not -iname "*.php"	# only 2 sub-dirs
# find . -maxdepth 2 -type f -not -iname -size +10k "*.php"	# only file > 10k
# find . -type d -iname "xx"	# find only dirs
# find . -type f -perm 664	# only files with permission 664
# find . -type f -size +1K
# find . -type f -size +1K -exec grep -i -n "function" {} +	# '+' will end the exec file, n means line numbers:w
# find . -type f -size +1K -exec grep -i -n "function" {} + | tee out.txt	# write to out.txt as well as display on screen
# ps aux 
# pgrep <process-name>		# shows u only the process id
# kill -9 <process-id>
# killall <process-name>
# sudo service <process-name> start
# sudo systemctl start <process-name>	# as above. new standard
# sudo service <process-name> stop
# sudo systemctl stop <process-name>	# as above. new standard
# sudo service <process-name> restart
# crontab -e 				# this open a crontab file to schedule a job to run at a certain time
#   m   h   dom mon  dow  command		# m = min, h = hour, mon = month, dow=day of week, command
#   15  14  *   *    *    ls > /home/nick/cron.log	# * means every. command is run at 14:15 every day
#   15  14  *   *    0    ls > /home/nick/cron.log	# run on sunday
#   15  14  *   *    1    tar -zcf /var/backups/home.tgz /home/ 	# backup home dir every monday
#   15  14  *   *    1    apt-get update -y 	# cwrun upgrade every monday
# 
# alias
# alias ec="echo"
# $PS1		# Prompt String 1. it is an inbuilt shell var
# [[ -f "$file" ]] && echo "found"	# && is used to chain commands together. second command runs if first one succeeds
# $TERM -> xterm
# $DISPLAY
# export DISPLAY
# set			# display all env vars as wells as vars set in current session
# set -o xtrace or set -o -x	# print a trace of simple commands when executed
# set -o +x		# to switch tracing off
# set -o noclobber  or set -o -C  (to switch off: set -o +C)
			# disallow existing regular files to be overwritten by redirection of output.
# set -o notify  or  set -o -b		# Notify of job termination immediately.
# set -o ignoreeof      # the shell will not exit upon reading EOF (i.e <ctrl> d )
# shopt			# to enable or disable options for current shell session
# shopt -s		# list all options that are currently set
# shopt -s cmdhist	# save all lines of a multiple-line command in the same history entry
# shopt -u mailwarn	# unset option
# shopt -s histappend histreedit histverify       #!! doesn't execute the last command, it allows u to modify the last command
# unset MAILCHECK        # Don't want my shell to warn me of incoming mail.
# # Pretty-print of some PATH variables:
# alias path='echo -e ${PATH//:/\\n}'		# echo -e  means translate special chars (i.e \n means new line)
# alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
# alias du='du -kh'    # Makes a more readable output.
# alias df='df -kTh'
# alias ls='ls -F --color=auto --show-control-chars'
# alias ls='ls -h --color'		# -h shows size in K, M,..etc (i.e 10K)
# alias lx='ls -lXB'         #  Sort by extension.
# alias lk='ls -lSr'         #  Sort by size, biggest last.
# alias lt='ls -ltr'         #  Sort by date, most recent last.
# alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
# alias lu='ls -ltur'        #  Sort by/show access time,most recent last.
# 
# # The ubiquitous 'll': directories first, with alphanumeric sorting:
# alias ll="ls -lv --group-directories-first"
# alias lm='ll |more'        #  Pipe through 'more'
# alias lr='ll -R'           #  Recursive ls.
# alias la='ll -A'           #  Show hidden files.
# alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...
# 
# function ff() { find . -type f -iname '*'"$*"'*' -ls ; }  #Find a file with a pattern in name:
# Find a file with pattern $1 in name and Execute $2 on it:
#   function fe() { find . -type f -iname '*'"${1:-}"'*' \
#   -exec ${2:-file} {} \;  ; }   # ${1:-} means if $1 is not defined then use nothing. ${2-file} means if $2 is not defined use file
#                                 # 'file' is a program that determines the type of a file
#
#
#-------------------------------------------- git
# on internet:
#   go to github.com and create an account (username: ghassemi100, password: xxxx, repository name: test)
#   ensure to click on the button to 'initialise with a readme file'
#   click on test repository, it shows you the URL (https://github.com/ghassemi100/test.git), copy it
# on unix shell:
#   git init		# to init git . it creates some sub-dirs called config,....etc
#   git remote add origin https://github.com/ghassemi100/test.git
#   git config --global user.name "ghassemi100"
#   git config --global user.email ghassemi@mailcity.com
#   git pull origin master	# this file copy the blank README.md from git repository to unix dir
#   git branch --set-upstream-to=origin/master	#set the upstream branch
#   git add example.sh   or   git add -A -> to add all changed files.
#   git commit -m "some files"
#   git push   or  git push origin master		# this will copy example.sh to repository
#   
#----------------------- check failed logins, get the IP address and their locations
# LIMIT='10'
# LOG_FILE="${1}"
# if [[ ! -e "${LOG_FILE}" ]]
# then
#     echo "cannot open the file" >&2
# fi
# grep Failed syslog-sample |awk #{print $(NF - 3)}' | sort | uniq -c | sort -nr | while read COUNT IP
# do
# if [[ "${COUNT}" -gt "${LIMIT}" ]]
# then
#     LOCATION=${geoiplookup ${IP} | awk -F ', ' '{print $2}')
#     echo "${COUNT},${IP},${LOCATION}"
# fi
# done

#--------------------------------------------- end of check
# sort x.txt 
# sort -r x.txt		# reverse the sort order
# cut -d ':' -f 1 x.txt	| sort 		# sort col 3 - doesn't sort numeric cols
# cut -d ':' -f 1 x.txt	| sort -n	# sort col 3 - sorts numeric cols
# cut -d ':' -f 1 x.txt	| sort -nr	# sort col 3 - sorts numeric cols in reverse order
# du /bin | sort -n		# disk usage sorted by size (in kilo bytes)
# du /bin -h | sort -h		# as abobe but in human readable format. size is displayed as 20K or 20M,.etc
# cat /etc/passwd | sort -t ':' -k 3	#sort by 3th field. cols are seperated by ':'
# cat /etc/passwd | sort -t ':' -k 3 -nr	# as above but sort numericall in reverse order

#----------------------- sed
#sed 's/my wife/sed/' love.text		#replaces the first occurance of 'my wife' on each line
#cat love.text | sed 's/my wife/sed/' 	# as above
#sed 's/my wife/sed/g' love.text	#replaces all occurances of 'my wife' on each line
#sed 's/my wife/sed/2' love.text	#replaces the 2nd occurance of 'my wife' on each line
#sed 's/my wife/sed/2' love.text > new.txt # create a new file
#sed -i.bak 's/my wife/sed/' love.text # -i implace edit (replace is done in the file), .bak means keep original file with extension .bak
#sed 's/my wife/sed/gw like.txt' love.text # w means create a new file called like.text containing only lines where replacement was done.
#sed 's/\/home\/jason/\/home\/james/' 	# to replace /home/jason with /home/james
#sed 's#/home/jason#/home/james#' 	#  as above but we are using # as the delimiter instead of '/'
#sed 's:/home/jason:/home/james:' 	#  as above but we are using : as the delimiter instead of '/'
#sed '/This/d' lov.txt			#delete lines containg 'This'
#sed '/^#/d' lov.txt			#delete lines starting with '#'
#sed '/^$/d' lov.txt			#delete blank lines'
#sed '/^#/d ; /^$/d' lov.txt		#delete comment and blank lines' . this is running sed with multiple commands
#sed '/^#/d ; /^$/d ; s/apache/httpd/' lov.txt		#delete comment and blank lines and replace text as well'
#sed -e '/^#/d' -e '/^$/d' -e 's/apache/httpd/' lov.txt		# as above as above .
# create a file called script.sed and add 3 lines: line1: '/^#/d'    line2: '/^$/d'  line3: 's/apache/httpd/'
# sed -f script.sed lov.txt		# executes lines in file script.sed
# sed '2 s/my wife/sed/' love.text	# execute the replace only on line 2 of the file
# sed '2s/my wife/sed/' love.text	# as above 
# sed '/Group/ s/my wife/sed/' love.text	# instead of using ann address like 2, we r using a regexp to find the lines that we want to execute the replace
						# i.e replace is done on lines that contain the word Group
# sed '1,3 s/my wife/sed/' love.text	# does the replace on lines 1, 2 and 3 
# sed '/#User/,/^$/ s/my wife/sed/' love.text	# does the replace on lines starting '#User' and ending on a blank line 
#---------------------------------------- end of sed

# ping -n 3  192.168.1.2		# -n meand sending count of 3 packets (could be -c in other system)
# ping -n 3  server01		# u can use server01 instead of the ip address if it is defined in /etc/hosts file (see below how to add it)
# echo '10.9.8.11 server01' | tee -a temp.txt 	# tee sends the text to standard output as well as appending to temp.txt (-a means append)
# sudo echo test >> /etc/hosts		# this won't work (permission denied) as we are only echo using the root user (sudo means run as root)
# echo '10.9.8.11 server01' | sudo tee -a /etc/hosts 	# this works
#-------------- to create sshkey pair to login to other machines without a password
# ssh-keygen		# this creates  rsa key pair (id_rsa and id_rsa.pub)
# ssh-copy-id server01	# this will ask for a password. enter a password
# ssh server01	# this should login without a password . note: this is a one way login. cannot login from server01 to local server without password. it can be setup that way as well.
# exit		# exit from server01
# ssh server01 hostname		# login to server01 and executes command hostname
# for N in 1 2
#   ssh server0${N} hostname	# login to server01 and server02 and executes command hostname
# done

# echo 'server01' > servers
# echo 'server01' > servers
# echo 'server02' >> servers
# for SERVERS in $(cat servers)
# do
#    ping -n 1 ${SERVER} &> /dev/null
#    if [[ "${?}" -ne 0 ]]
#    then
#       echo "${SERVER} down."
#    else
#       echo "${SERVER} up"
#       ssh ${SERVER} hostname
#       ssh ${SERVER} uptime
#    fi
# done

# ssh server01 hostname ; hostname	# ';' is command seperator. 2nd hostname will get executed on the local host
# ssh server01 'hostname ; hostname'	# ';' is command seperator. 2nd hostname will also get executed on server01
# ssh -o ConnectTimeout=2 server01 'hostname ; hostname'	# set timeout to 2 sec 

# CMD1='hostname'
# CMD2='uptime'
# ssh server01 "${CMD1} ; ${CMD2}"	# must use double quote to expand the vaiables

# ssh server01 'ps -ef | head -3'	# run ps on server01. head -3 means take top 3 processes
# ssh server01 ps -ef | head -3		# head -3 is execute on local server and not or server01
# ssh will exit with exit status of the last remove command or 255 if an error occured with ssh itself
# ssh server01 'false | true'		# this return 0	 (because last command executed is true)
# ssh server01 'true | false'		# this return 1
# ssh server01 'set -o pipefail; false | true'  # this return 1. the return value of a pipeline is the status of the last command to exit with a non-zero status
						# or zero if no command exited with a non-zero status

# ssh server01 sudo id		# this gives the id of root on server01	(because we r using sudo  which means run as root. no root password is required here)
# sudo ssh server01 id		# this logs in as root to server01 and run id command as root but u need the root password on server01 to execute this command
# 

# sort 
# 
#


# if [[ ! -d "${DIR}" ]]	# if a dir doesn't exists
# USERID=$(id -u ${USERNAME}) 	#assume USERNAME is set to a valid username
# userdel <user>	# to delete a user account
# userdel -r <user>	# -r remove the user's home dir
# chage -E 0 woz	# to expire account woz (prevents a user authenticating with sshkey)
# chage -E -1 woz	# to re-activate account woz
# passwd -l woz		# lock account woz (doesn't prevent a user authenticating with sshkey )
# passwd -u woz		# to unlock it
# usermod -s /sbin/nologin woz	#set shell of woz to nologin to prevent login in

# tar cvf c.tar ./	# Old stype (no dash. all options should be after tar and stuck together)
                        # c = create, v = verbose, f = file.
# tar -cvf c.tar ./	#az above
# tar -f c.tar -c -v ./	#az above
# tar xvf c.tar
# tar tvf c.tar   #  tar overwrite existing files
# gzip c.tar	# too compress a file
# gunzip c.tar.gz
# tar zcvf c.tar.gz ./	# tar and compress
# tar zcvf c.tgz ./	# tar and compress
# tar ztvf c.tar.gz
# tar zxvf c.tar.gz
#
# ls c.1 c.2
# cat !$	# take the last argument of previous command (i.e c.2)
#  id -u SJG	# gives the id of user SJG
#  id -u 	# gives the id of current user (id < 1000 are for system accounts)
# tail /etc/passwd	#password file
#  !!		# !! means executed the last command	
#  ls -ld /*bin
#locate .bashrc	| grep bin	# to locate a file
# find /usr/* -name fold.exe 	# find/locate a file
#su - <username>		#start a login shell with an environment similar to that of the real login
#su -l <username>	#same as above
#chmod 755 <filename>
#chmod +x <filename>
# echo $HOSTNAME
# hash -r	#removes hash table that bash uses to remember the path of executables.
		# if you create /xx/yy/e.sh and execute it. bash will remember that u ran it from /xx/yy
		# if u then delete it, and run it again, it still look at xx/yy even though there is anoth e.sh on path
# sleep 10m	# sleep for 10 monutes
# id -un	# print USER name
#------------------------- creating unique and difficulat to guess passwords
#echo ${RANDOM}
#PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
#PASSOWRD=$(date +%s)	# + means formating date  %s means no. of seconds elapsed since 1/1/1970
#PASSWORD=$(date +%s%N)	# %N means nanoseconds
# date +%s | cksum	#cksum is a numeric value computed for a block of data that is relatively unique
# date +%s | sha256sum	#sha256sum also computes a checksum  - use this to create a unique password
#		output from above is: 9d48fa545a31fda8888d2f3375c706c6c10cde326678f699ed419f9376173ef7 *-
# tail -3 <filename>
# head -n 1 <file>	# print first line of file
# head -1 <file>	# as above
#head -c1 file     	# print first char of file
#echo "testing" | head -c2	# will print te
# PASSWORD=$(date +%s%N | sha256sum | head -c32)	#get the first 32 chars
# PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)	#get the first 48 chars
# S1='!@#$%^&*()_+='
# echo "${S1}" | fold -w1 | shuf | head -c1	# fold will break each char into a seperate file
						# shuf will shuffle the lines
						# head will get the first char
						# result is that we get a random special char from $S1

# SPECIAL_CHAR=$(echo '!@#$%^&*()_+=' | fold -w1 | shuf | head -c1)	# fold will break each char into a seperate file
# echo "${PASSWORD}${SPECIAL_CHAR}"	# append special char to end of password
#
#------------------------------ parameter expansion
# u=${1:-root)		# setting default value for $1 (positional parameter). if not set, user 'root'
#_mkdir(){
#        local d="$1"               # get dir name
#        local p=${2:-0755}      # get permission, set default to 0755
#        [ $# -eq 0 ] && { echo "$0: dirname"; return; }
#        [ ! -d "$d" ] && mkdir -m $p -p "$d"
#}
##
# ----- var=${USER:=value}		# setting default value for a var
# echo ${USER1:=foo}		# if USER1 has no value, assign foo to it
# echo ${USER1:=xx}		# it will still echos foo. to exho xx, u must first do   unset USER1 
#
# ---- ${varName?Error varName is not defined}	# error msg is var not defoined
# ${varName:?Error varName is not defined or is empty}  	# error msg when var not defined or empty
# ${1:?"mkjail: Missing operand"}
# MESSAGE="Usage: mkjail.sh domainname IPv4"             ### define error message
# _domain=${2?"Error: ${MESSAGE}"}  ### you can use $MESSAGE too 
#
# ---- len=${#var}		# to get var length
# 
# ---- ${var#pattern}  or  ${vari##pattern} # to remove a pattern (# removes shortest part and ## removes longest part) from front of a var
# f="/etc/resolv.conf"
# echo ${f#/etc/}	#removes /etc/ from var f
#
# _version="20090128"
# _url="http://dns.measurement-factory.com/tools/dnstop/src/dnstop-${_version}.tar.gz"
# echo "${_url#*/}"		# this gives /dns.measurement-factory.com/tools/dnstop/src/dnstop-20090128.tar.gz
# echo "${_url##*/}"		# this gives dnstop-20090128.tar.gz
# _self="${0##*/}"		# this gives script name without using /bin/basename
#
# ----- ${var%pattern} or ${var%%pattern} 	# remove patterm from end of var (shortest/longest)
# FILE="xcache-1.3.0.tar.gz"
# echo ${FILE%.tar.gz}			# this gives xcache-1.3.0
#
# for p in /scripts/projects/.devl/perl/*.perl		# rename all *.perl to .pl
# do
#	mv "$p" "${p%.perl}.pl"
# done
#
# ----- ${varName/Pattern/Replacement}	# find and replace: ${varName/word1/word2} or ${os/Unix/Linux}
# x="Use unix or die"
# echo "${x/unix/linux}" or out="${x/unix/linux}" 	# instead of using:  sed 's/unix/linux/' <<<$x
# out="${x//unix/linux}"		# to replace all matches of pattern
# 
# y=/etc/resolv.conf
# cp "${y}" "${y/.conf/.conf.bak}"	# to rename files
#
#----- substrng starting character
# ${parameter:offset}  
# ${parameter:offset:length} 
# ${variable:position} 
# var=${string:position}
#   base="/backup/nas"    file="/data.tar.gz"
#   path="${base}/${file:1}"	# strip extra slash from $file  ####
# x="nixcraft.com"		# to extract craft only
#   echo ${x:3:5}"
# phone="022-124567887"
#   echo "${phone:4}"		# strip std code
#---- get list of matching variables
# VECH="Bus"  VECH1="Car"  VECH2="Train"
# echo "${!VECH*}" 	# this will echo all above
#-------- convert to upper/lower case
# name="vivek"
#   echo ${name^}		# converts 1st char tp uppercase --> Vivek
#   echo ${name^^}	# converts all chars tp uppercase --> VIVEK
#   name="VIVEK"
#   echo ${name,}		# converts 1st char tp lowercase --> vIVEK
#   echo ${name,,}	# converts all chars tp lowercase --> vivek
# dest="Home"
#    echo "${dest,H}"	# only convert H if it is capital --> it becomes 'home'
# dest="Fhome"    
#    echo "${dest,H}"	# this would not change h
#

##----------------------o "${PASSOWR- create user account
if [[ "${UID}" -ne 0 ]]
then
	echo 'please run with sudo or as root.'
	#exit 1
fi

#read -p 'Enter username: ' USER_NAME    # reads one line from stdin and store in variable $USER_NAME
#read -p 'Enter real username: ' COMMENT
#read -p 'Enter password: ' PASSWORD
#useradd -c "${COMMENT}" -m ${USER_NAME}   # create a new unix user . -m means create a home dir. COOMENT is in double quotes as it may have spaces
# if [[ "${?}" -ne 0 ]]
#then
#	echo ' the account could not be created'
#	exit 1
#fi

#echo ${PASSWORD} | passwd --stdin {USER_NAME} #--stdin mean take stdin as password. stdin comes from echo using '|'
#password -e ${USER_NAME}	#force password change on first login
# 
# echo "secret" > password_file
#sudo passwd --stdin einstein < password_file 	# to pass content of password_file as stdin to passwd
# cat password_file

#----------------------------- parameter processing
echo "you executed this command ${0}"
echo "you use $(dirname ${0}) as the path to the $(basename ${0}) script"
NUMBER_OF_PARAM="${#}"
echo "you supplied ${NUMBER_OF_PARAM} parameters"
if [[ "$NUMBER_OF_PARAM" -lt 1 ]]
then
	echo "pass at least 1 parameter"
fi

#---------- generate a password for each parameter
#for USER_NAME in ${@}   # ${@} is equiv to $1, $2, $3,...	(all params are treated seperately)
#for USER_NAME in ${*}   # same as above  (note there are no double quotes around ${*} and ${@}
for USER_NAME in "${@}"   # same as above but double quotes used here
#for USER_NAME in "${*}"    # "${*}" is equiv to $1c$2c$3c.... (all parameters are stuck together (it is list of all param on 1 line))
do
	PASSWORD=$(date +%s%N | sha256sum | head -c48)
	echo "${USER_NAME}: ${PASSWORD}"
done

#------------------------------ while loop

#while [[ "${#}" -gt 0 ]]
#do
#	echo "No. of params: ${#}"
#	echo "Param1 ${1}"
#	echo "Param2 ${2}"
#	shift		# remove parameter from start which mean number is ${#} reduces by 1
#done

#PARAM1=${1}
#shift
#OTHER_PARAMS="${@}"  # if we pass aa bb cc, OTHER_PARAMS will be set to "bb cc"
#echo "P1: $PARAM1   P2: $OTHER_PARAMS"


#------------------- redirect STDOUT to a file
FILE="./temp.txt"
head -n1 ./test.sh > ${FILE}
#head -n1 ./test.sh 1> ${FILE}	#as above. 1 is the file descriptor for stdout
#--------- redirect STDIN to a program
read LINE < ${FILE} 	# reads the first line from file
#read LINE 0< ${FILE} 	# as above. 0 is file descriptor. 0 for stdin, 1 for stdout, 2 for stderr
echo "Line: $LINE"

#echo 'error on line 100' 1>&2 	# 1>&2 means stdout (1 is file descriptor for stdout) redirected to &2 which is stderr file descriptor
#echo 'error on line 100' >&2 	# same as above
#useradd -c "${COMMENT}" -m ${USER_NAME} &> /dev/null	#&> mean both stdout and stderr redirected to null device
#head -n1 temp.txt test.sh xx 1> std.out 2> std.out	# 2> means stderr (2 is file descriptor for stderr). any error is sent to head.err
#head -n1 temp.txt test.sh xx 2> head.err	# 2> means stderr (2 is file descriptor for stderr). any error is sent to head.err
#head -n1 temp.txt test.sh xx 2> head.err > head.out	# 2> means stderr (2 is file descriptor for stderr). any error is sent to head.err
#head -n1 temp.txt test.sh xx 2>> head.err > head.out	# 2>> append to head.err
#head -n1 temp.txt test.sh xx > head.out 2>&1	# 2>&1 means re-direct 2> which is stderr to &1 which is stdout (1 is file descriptor for stdout)
#head -n1 temp.txt test.sh xx &> head.out 	# as above (new syntax)  - redirect both stdout and stderr to head.out
#head -n1 temp.txt test.sh xx &> /dev/null 	# stderr and stdout are written to null device which is thrown away
#head -n1 temp.txt test.sh xx | cat -n 		# stderr does not go through the | so cat only counts no. of line in stdout lines
#head -n1 temp.txt test.sh xx 2>&1 | cat -n 	# stderr goes to stdout and then goes through the | so cat counts lines in stdout and stderr
#head -n1 temp.txt test.sh xx |& cat -n 	# as above
#echo "another line" >> ${FILE} 	#to append another line
#cat ${FILE}

# NUM=$(( 6 % 4 ))	# modulus gives remainder. can be used to distiquish between even and odd numbers (even%2=0 odd%2=1)
# NUM=$(( 1+2 ))	# arithmatic expansion - doesn't support floating point math (no decimals). round up results. 6/4 = 1
# awk 'BEGIN {print 6/4}'	# this gives 1.5
# d1='3'
# d2='6'
# total=$(( d1 + d2 ))
# NUM='1'
# (( NUM++ ))	# increment a var
# (( NUM-- ))
# NUM=$(( NUM += 5 ))
# let NUM='2 + 3'	# let is equiv to using (( 2 + 3))
# let NUM++
# expr 1 + 1   		# result is output to stdout
# NUM=$(expr 2 + 3)

#---------------------How do I comment all lines in Vim?
#To comment out blocks in vim:
#press Esc (to leave editing or other mode)
#hit ctrl + v (visual block mode)
#use the up/down arrow keys to select lines you want (it won't highlight everything - it's OK!)
#Shift + i (capital I)
#insert the text you want, i.e. %
#press Esc Esc.
#
# to highlight search string in vi:  :set hlsearch    
# to switch it off:  set: nohlsearch

#----------------- case example
echo "------------ param1: $1"
#if [[ "${1}" = 'start' ]]
#then
#	echo "startng"
#elif [[ "${1}" = 'stop' ]]
#then
#	echo "stopping"
#elif [[ "${1}" = 'status' ]]
#then
#	echo "status"
#else
#	echo 'supply a valid option' >&2
#	#exit 1
#fi
#
case "${1}" in
	start)
		echo 'Starting'
		;;
	stop)
		echo 'Stoping'
		;;
	status|state|--state) echo 'status' ;;
	rest*) echo 'rest*' ;;
	*)
		echo "supply a valid option"
		;;
esac	# case backwards

#------------------------------ functions
#function log {   # as  below
log() {
  #local VERBOSE="${1}"
  #shift
  local MSG="${@}" 	# local can only be used inside a function , ${@} is all the positional parameters starting from position 1
  			# without local, it will be global but will only be set after function is called (bad practice to use global inside a func
  if [[ "${VERBOSE}" = 'true' ]]
  then
     echo "using passed parameter: $MSG"
  fi

  if [[ "${GLOBAL_VERBOSE}" = 'true' ]]
  then
     echo "using global variable: $MSG"
  fi
  ##logger -t test.sh 'msg from logger'# this will write a line to /var/log/message file
}

backup_file() {
	local FILE="${1}"
	if [[ -f "${FILE}" ]]
	then
		local BACKUP_FILE="$(basename ${FILE}).$(date +%F-%N)"
		log "Backing up ${FILE} to ${BACKUP_FILE}."
		cp -p ${FILE} ${BACKUP_FILE}
	else
		return 1  # return from this function (not script)
	fi
}

#---------------------------------------------------- calling functions
log 		# this calls the log function
#log 'true' 'Hello'
log 'Hello'
readonly GLOBAL_VERBOSE='true'
#log 'true' 'this is fun'
log 'this is fun'

#backup_file ${1}
#if [[ "${?}" -eq '0' ]]
#then
#	log 'file backed up'
#else
#	log ' file backup failed'
#	#exit 1		# exit from the script  (return exits from the function)
#fi
#

usage() {
	echo "Usage ${0} [-vs] [-l length]" >&2
	echo '   -l   length'
	echo '   -s   special char'
	echo '   -v   increase verbosity'
	#exit 1
}

log2() {
	local MSG="${@}"
	if [[ "${VERBOSE}" = 'true' ]]
	then
		echo "${MSG}"
	fi
}
#-------------------- use getopts  (there is also getopt which is more restricted)
while getopts vl:s OPTION	#v,l,s are options. l has a mandatory argument - Note  i
				# :vl:s  (: at start of list) means switch off default invalid option handling and capture it using ?)
do
	case ${OPTION} in
		v) VERBOSE='true' 
		   log2 'verbose mode on' ;;
		l) echo 'length' ;;
		s) echo 'special' ;;
		?) echo 'invalid option' >&2 
		   usage ;;	# could have used *)
	esac
done

#------------- getopts doesn't change the position of the parameteris. processed options are not removed
# to remove the processed parameters, you have to shift
echo "--- OPTIND: $OPTIND"	#$OPTIND is set to number of parameters + 1 
shift "$(( OPTIND - 1 ))"	# removes the options while leaving the remaining arguments

if [[ "${#}" -gt 0 ]]
then
	echo "--- left arguments are: ${@}"
	count=0
	for ARGUMENT in "${@}"
	do
		echo "Argument $count: ${ARGUMENT}"
		#(( count++ ))
		let count++ 	# as above
	done

	usage
fi

#---------------------------------------------- vim
# wq!	write and quit
# set ruler	# to see line and col 
# set noruler   # switch it off
# set ruler!	# to toggles the set ruler on or off
# w W b B gg 3gg :$ :1 1G dw d2w 2dw 2dW dW x X d$ shift-d  db dB 3dd  yw  2yw .  
# :help  :help dd   <ctrl>o to go back to previous help page    <ctrl i> go to next help screen
# <ctrl> ww	to switch between help screen and our file screen
# :help :q <ctrl>d	this shows all commands start with q . use tab i( and left arrow key) to scroll through 
# :h ctrl-f    or   :h ^f
# in help screen place the cursor on a highlight text and press <ctrl>] to get the help for that topic. to go back press <ctrl>o. to goo fwd press <ctrl> i
# :set wildmenu		this gives you the menu with choices to tab through when using above command 
# z - enter	# this moves the screen up but keeps the cursor on the same line
# <ctrl>r	# repeat the last command
# :reg		# to look at registers (they hold yanked, deleted or changed text)
# 		# to paste the most recently yanked text do: "0<shift>p	, "0 is 0 register
#		# to paste text from rtegisters do :  "0p  "1p    "2p    "3p ,....etc
# "ayy		# this yanks a line into register a    "byy   store in b register
# "ap		# too paste from a register
# "Ayy		# to append to register a
# "zdw		# delete word and place in reg z
# :reg 1z	# show register 1 and z   :reg 1 -> show reg 1
# "hyy		# save into reg h
# "h2p		# paste twice from reg p
# ""		# this is call unnamed register which is used by default by vim for yanking, deleting, pasting,..
# "0..."9	# numbered registers
# "a...."z	# Named registers
# "A..."Z	# to append
# <shift>I	# will move to first non-blank char of the line and then goes into insert mode
# <shift>A	# append to end of line
# 80i*<esc>	# repeat '*' 80 times
# 5o#<escc>	# add 5 lines starting with #
# <shift>r	# go into replace more to overwrite text
# cw		# change word
# "acw		#change word but put the original word in register a
# c$		#change from current cursor position to end of line
# C		# as above
# cc		# replace an entire line of text
# 3cc		# replace 3 lines
# ~		# converts lower case to uppercase and vise versa
# g~w		# as above but for a word
# g~$		# as above but for entire line
# g~~		# as above
# Note: 2 commands like d or y or ~ operate on entire line
# gUw		# convert the word to uppercase
# gUU		# as above but for a line
# guu		# as above but lowercase
# guw		# as above but for a word
# gJ		# join lines without adding space to end of first line
# 3J		# join 3 lines together
# fb		# find the next b on the line	fB too find B
# Fb		# as above but go backwards
# ;		# to repeat the search with fb or fB
# ,		# as above but go backwards
# tp		# put the cursor before the char before next p . to repeat use ;  or , as above
# Tp		# as above but goes backwards
# 2fb		# stop at 2nd b
# dtp		# delete to next p
# dfp		# as above but also deletes p  (delete upto space if there is a space before p)
# :set is?	# if incsearch is set, you will see the word 'insearch' at the end of screen
# :set is	# to set it
# :set hls?	# to set it do:  :set hls    to unset it:  :nohls   or  :set nohls
# ?is		# search backward for 'is'
# *		# find the next word which is under the cursor
# ?		# as above but going backwards
# "ad\This	# delete everything till 'This' and put it in reg a
# :s/old/new/g
# :1s/old/new	# change on line 1 only
# :1,5s/old/new/g	# change on line 1 to 5
# :.,$s/old/new/g	# change from current line to end of file
# :%s/old/new/g		# change entire file
# :/Global/, /Local/s/old/new/	# change are done only between patterns: 'Gobal' and 'Local'. 
# :/Global/, $s/old/new/	# change are done only between patterns 'Gobal' and end of line
# :s/\var/\bar/g		# replace /var  with  /bar
# :s#/var#/bar/g		# use # as a seperator instead of /	
# :set nu    or :set number	# set line numbering
# :set nonu			# switch it off
# :set nu!			# to toggle line numbering on or off
# ------------------------- vim text objects
# {operator}{a}{object}  or {operator}{i}{object}
# daw		# delete a word
# ciw / cis / cip /diw /dis / dip /daw /cas /cap	# changeInnerWord, sentense, paragraph
# ci] / ci) or cib 			# b statnds for block
# cit / cat				# t = tag (example: <p> tag </p>
# ci" / ci' / ci`				# change text between "" or ''
# "iyci}		# yank text within {} into register i ("i means register i)
# >i}			#indent all lines between {}
# ------- macros. always start at start of line, do some actions and then go too next line with j before ending the macro.0
# qa	# to start macro placed in register a. enter some text, do something else.
# q	# to end macro recording
# @a	# to play macro a
# @@	# execute the most recently executed macro
# 5@a	# means execute macro a 5 times
# qC	# appends to queue c  (capital c means append)
# :27,35normal @d	#apply macro d on lines 27 to 35  (get line numbers by :set num)
# :.,$normal @d		#apply macro d from curent line to end of file (. means current line. $ means end of file)
# "ap			# paste content of register a   ("a means register a)
# "ay$			# yank to end of line into register a (use with line above to change content of a register)
# let @d = '0jDkPa /<80>kb^[/ h^MDj2dd'  # put this in .vimrc or _vimrc to load the next time u run vim inorder to set register d
# let @t = 'ITODO: ^[j'	# u can enter macros manually on line. to enter escapes do: <ctrl>v<escap> to get the literal character for escape
#--------------------------- visual modes
# :set shiftwidth?	# shows the shift setting width (when we use > on keyboard). if shiftwidth = tabwidth, tabs will be used
# :set tabstop?		# shows the tab setting width 
# :set expandtab?	# shows if tabes will be replaced by spaces or not
# :set expandtab	# to set it (tabs will be replaced by spaces)
# :set list		# display the tab chars (^I) on screen
# :set list!		# to switch it off/on
# :set nu!		# to set line numbering on/off
#
# v or V  or <ctrl>v	# visual, line visual, block visual
# v -> 2w -> d		# visual mode, select 2 words and delete
# V -> ip > J		# line visual, select paragraph , join all lines together
# V -> j -> U		# select 2 lines and turn to uppercase
# gv -> :'<,'>center<enter>	# select the previous visual line block (gv) -> command line --> center to center text
# gv -> :'<,'>ce<enter>	# as above
# <ctrl>v --> move to left and then down a few lines to select the block --> d  # to delete a block
# <ctrl>v --> move a few lines down --> I --> enter # --> escape	# to enter a # at the start of each line
# <ctrl>v --> move a few lines down --> $ --> A --> enter # EOL --> escape	# to enter '# EOL' at the end of each line
#  
# -------------------------- vim setting ->  .vimrvc , each line in .vimrc file is executed
# :version		# press enter to go to end and see where 'system vimrc file and user vimrc file are stored'
# :set			# to see the list that differ from the default value
# :set hls?		# to see if hlsearch is set or not
# :set hls  or :set nohls or :set hls!
# h hls			# to see help on hls
# :set history?		# to see the number set for history
# :h history<ctrl>d	# to see all topics about history. we could select 'history'
# :h 'history'
# :set history=500
# :<up arrow>	or :h<up arrow>		# to go through the history of commands
# :set history&		# to return history to its default value
# :e ~/.vimrc		# edit ~/.vimrc file
# :h option-list	# to see a list of options for set
# :options		# as above but with description
# :set ruler		# show cursor position at all time
# :set showcmd		# show incomplete commands (i.e when u type '2y', it shows it at the bottom of screen because it is incomplete
# :set wildmenu		# gives u a menui when using tab completion, try this ->   :h hist<tab><row arrow>   . now u get a menu to choose from
# :set scrolloff=5  or set so=5	# works with z<enter>. it means keep 5 line on top
# :set backup		# creates ~.<filename> when exit from file
# :set bex=SOMETHING	# use SOMETHING as file extension for the backup file instead of ~
# :set lbr		# when wrapping lines, don't break the words
# :set ai		' auto intent. indentation are copied to next line
# :set si		# smart indent
# :set bg=light or bg=dark
# :set color <ctrl>d	# to get a list of color schemes
# color schemes are stored in a subdir: ~/.vim/colors
# source .vimrc		# executes command in the file
# map <F2> iJohn Smith<CR>123 Main Street<CR>Anytown, Ny<CR><ESC>
# map <F3> i<ul><CR><Space><Space><li></li><CR><Esc>0i</ul><Esc>kcit	# kcit means k:up 1 line, cit: change inner tag. i
									# this means curso will be inside the tag when F3 is pressed
# map <F4> <Esc>o<li></li><Esc>cit	# use with F3 to add multiple tags
# map <leader>w :w!<CR>		# to define a leader key to execute a command. this means if u type \w  it will execute :w!<CR> to save the file
# let mapleader=","		# this means instead of using '\' key as the leader ket, use ','
# map				# to say all mappings
# h mapping			# to see help for mapping
# :mkvimrc testvimrc		# to create a vimrc file with current map and key setting
# :mkvimrc!			# to overwrite the existing vimrc file
# :e <enter>			# to reload the file u r editting 
# :e ~/.test_vimrc		# "vy<strl>G --> :e ~/.test_vimrc --> "vp	: yank the entire file into reg v, open a new file and paste content of register v into it.
# ------------------------------------- multiple file editng
# :buffers		# to see what is loaded
# :ls			# as above
# :h :buffer		# to see help on buffer
# :buffer 2		# go to buffer 2
# :b2			#as above
# :b buf-dad.txt	#as above
# :b <tab> <right arrow> to select a file
# :b <ctrl> d	to see the list
# :bnext or :bn or :bprevious or :bp or :bf i(first buffer) or :bl (last buffer) or <cntl><shift>6 (this goes back to prevous buffer)
# :qall!			# to quit all buffers
# :wall			# to save all buffers
# :badd modes.txt	# to add a new file without switching to it.   :e modes.txt  will load and switch to it
# :bdelete  or  bd or bd3	# to delete a buffer
# 1,3bd				# delete buffer 1 to 3
# %bd				# to delete all buffers
# :bufdo set nu!		# set nonumber for all buffer
# :bufdo %s/#/@/g | w		# change each buffer and save them
# :set hidden   and then u can do :bufdo %s/#/@/g     without the '| w' because in hidden mode u can change buffers and move to other buffer without saving them
# :E  	# to get a list of files in current dir. select a file and press enter to load
# 	# :bd to delete this buffer 
# <ctrl>^	# to go to previous buffers
# ------------------------------------------------- windows
# :sp	or :sp <file-name> or <ctrl>w s		#split window into 2 windows
# :vsplit  or  :vs  or  :vs <file-name>  or <ctrl>w v		#split vertically
# :q   or  <ctrl>w q		# to quit a window
# :only   or  :on  or ^w o		# close all windows except the one you are on
# ^w c					#close current window
# <ctrl>w w   <ctrl>w j <ctrl> w k <ctrl>w h  <ctrl>w l		#to navigate between windows
# <ctrl>w +  or  <ctrl>w -  or  <ctrl>w >   or  <ctrl>w <		# to resize a window
# resize 10  or res 20		# to resize a window
# vert resize 10  or  vert res -10	# to resize vertically
# ^w=		# to make all windows equal size
# <ctrl>w _	# to maximize the height of a window
# <ctrl>w |	# to maximize the width of a window
# <ctrl>w =	# to make all windows equal size
# :h ^w		# to see help on ^w
# <ctrl>w r	# to rotate windows
# <ctrl>w R	# rotate windown in opposite direction
# <ctrl>w h/j/k/l	# to move cursor among windows left/up/down/right
# <ctrl>w H/J/K/L	# to move windows left/up/down/right
# :ball  or :ba		# to open all buffers in windows
# :windo %s/This/That/g		# to change text in all open windows
# :bufdo %s/This/that/g		# changes all buffers whether displayed or not
# :h ^ww			# to see help on <ctrl>ww
# :r <file-name>		# read file
# :r !ls			# executes ls command on unix and sends output to vi
# :.-8r !ls			# . means current line, -8 means 8 lines above current line, r means read,  !ls means execute ls command on unix
				# output from ls is place 8 lines above current line
# :vimgrep foo **     and then   :copen to browse through results and select file to open
# :diffthis or :difft	#load 2 similar files with differences vertically side by side and then  :diffthis  on both windows to see the diffs
# vimdiff : on command line do vimdiff <file1> <file2> to see the diffs side by side in vim . gvimdiff is the graphical version
# :syntax on			# to use colours for diff parts of text
# =G				# to indent the file
# filetype plugin indent on	# write this to .vimrc to enable the above command (=G)
# set sw=2 ts=2 expandtab	# set shift-width and tabstop and expandtab in .vimrc
# :.!ls				# .! will execute the next command (i.e ls) and inserts the results into the buffer
# :.!date			# insert date into text
# i to go into insert mode ---> ^r=  then type 1+2 and u get 3	# calculator0
# ^a     			# place the cursor over a number and press ^a to increment it or ^x to dec
#  find . -name '*.cc'		# to find all .cc in all sub-directory
#  find . -name '*.cc' | xargs ls -l		# to find all .cc in all sub-directory and pass to xargs
# find . -name '*.cc' -exec grep -i inifile '{}' \;	# use -exec instead of xargs if no. of arguments are very large
							# '{}' is the place holder for the filenames
							# must end with \; to end the command to -exec
# set path			# shows the current path
# set path+=../include			# to add to path
# gf:  place cursor on an include filename on top of a .cc code and press 'gf'. it will open the include file
# ^w^f				# as above but it will open the include file in a seperate window.
# gd				# place cursor on a var and type 'gd', it will take you to its declaration
# ma   or   mb			# mark a line as 'a' or 'b'
# 'a   or   'b			# go to line marked as 'a'  or  'b'
# ''				# goes back to previous marked line
# cd <dir>			# change dir
#---------------------- completion
# i -> ^r -> a or b or c or.	# paste from reg a, b, c,..etc with ^r
# i -> type some text -> ^r -> .	# to repeat what was inserted
# i -> ^a				# to repeat what was inserted last time
# type qu and then ^p or ^n		# it shows it a list of all words starting with 'qu' matched from all .cc 
# i -> type I^x^]			# it shows all classes/functions starting with I (using tags files)
# Place cursor over a function name and ^] will take u to declaration file. 
# then ^o  or ^i  or ^t to move between files
# i -> type 'ta' and then ^x^f		# it complets 'ta' to 'tags' if there is a file called tags in current dir
# i -> type 't' and then ^x^f		# it shows a list of all files starting with 't'
# i --> type something and ^x^p or ^x^n		# to auto complete from previous/next text
# i --> type something and ^x^l			# to auto complete the whole line by matching with previous lines
# repeat ^x^l again and it copies the next line
# type pConfig.^x^o		# it shows you all the elements of the pConfig structure to choose from
# set complete			# shows u where it looks for completion
# set spell			# enables spell checking
#----------------------------------------------
# place cursor on a word --> * 			#to search for that word
# place cursor on a word --> / --> ^r^w 	#to search for that word
# Tags: download ctags.exe --> go to root of all your code --> ctags -R .	# this creates a file called tags with all the tag names 
# Tags: then place cursor on a function/var name and press ^}. it takes to that function/var definition
# :tn   or   :tp     or   :tags		# to go to next, prev tags or see where u r.
# :ta<space><tab>  or ta Ass<space><tab>	# shows u a list of tags or tabs starting with Ass
# V -> down a few lines --> =		# to allighn lines
# ^v --> down a few lines --> c --> # 	#to replace block text to #
# enter 'hel' --> ^n			# does a completion by offering a list of text starting with hel
# enter 'hel' --> ^x^o			# as above but shows all the parameters for functions
# enter "~/   --> ^x^f			# gives u a list of files/dirs from ~/
# :h ^x^o    or   :h ^x^f		# to get help on these
# ZZ					# to exit from help screen
# :ia B Buffer				# assigns Buffer to B. Type B<space> and it expands to Buffer
# type x = 3; --> place cursor on 2 and press ^a to increment the number abd ^x to decrement it
# 
