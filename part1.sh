filename= 
new_line=
cdate=$(date +'%X-%Y-%m-%d')
chour=${cdate:0:2}
cminute=${cdate:3:2}
cday=${cdate:17:2}
cmonth=${cdate:14:2}
cyear=${cdate:9:4}
logfile_timestamp=$(echo "$chour""$cminute""_""$cday""$cmonth""$cyear" )
prefix_rs="folder_name_rs_"
prefix_cs="folder_name_cs_"
prefix_e="folder_name_"
suffix_log=".log"
suffix_dat=".dat"
find_extension="false"
extension=
function rs_command()
{

	cd $filename
	find . -type d > list.txt
	while read line
	do
		new_line=$(echo $line | tr -d ' ')
		#echo $line
		#echo  $new_line
		if [ "$line" != "$new_line" ] ; then
			if [ "${line:0:1}" == "." ] ; then
				mv -f "$line" "$new_line"
			else			
				mv -f ".""$line" ".""$new_line"
			fi
			find . -type d > list.txt
			echo "$line" "->" "$new_line" >> $prefix_rs$logfile_timestamp$suffix_log
		fi
	done < list.txt
	rm -rf list.txt
	cd ..
}
function cs_command()
{

	cd $filename
	find . -type d > list.txt
	while read line
	do
		new_line=$(echo $line | tr '[:upper:]' '[:lower:]')
		if [ "$line" != "$new_line" ] ; then
			if [ "${line:0:1}" == "." ] ; then
				mv -f "$line" "$new_line"
			else			
				mv -f ".""$line" ".""$new_line"
			fi
			find . -type d > list.txt
			echo "$line" "->" "$new_line" >> $prefix_cs$logfile_timestamp$suffix_log
		fi
	done < list.txt
	rm -rf list.txt
	cd ..
}

while [ "$1" != "" ]; do
    case $1 in
	-u  | --usage) 			echo "part1 <-u>/<-h>/<-f  folder_name <-rs>/<-cs>/<-e file_extension>>"
				;;
        -f | --file )           shift
                                filename=$1
                                ;;
	-rs | --removespace)    rs_command;;
	-cs | --convertsmall)   cs_command;;
	-e | --extension)       find_extension="true"
				shift
				extension=$1
				;;
      
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ "$find_extension"=="true" ];then
	find $filename -type f -name "*.""$extension" > "$prefix_e""$extension""_""$logfile_timestamp""$suffix_dat"
fi

