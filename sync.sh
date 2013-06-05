#!/bin/bash
clear
cat <<EOT
#Shell script to sync prod
#-------------------------------------------------------------------------
#Version 1.0 (June 04 2013)
#-------------------------------------------------------------------------

EOT

source "projects.sh"
# projects  : project name
# jenkins	: jenkins workspace path
# remote_dir: path in production server


sync () {
	rsync --delete -avz --exclude=".svn*" -e "ssh -p 6666" $1 $2@$3:/home/$4
}

echo 'Available projects :'
i=0
for project_name in ${projects[*]}
do
	echo "[$i] $project_name"
	i=$(( i++))
	let i++
done
echo ""
read -p "Choose the project you want to merge in Prod (type id ex: 0)" PROJECT_ID
echo ""
if [[ ${projects[$PROJECT_ID]} ]]; then
	rev=`sudo svn update ${jenkins[$PROJECT_ID]}`
	infos=`svn info ${jenkins[$PROJECT_ID]}  | grep "modification"`
cat <<EOT
=================================================================
$infos
=================================================================

=================================================================
Origin : ${jenkins[$PROJECT_ID]}

Target : ${remote_dir[$PROJECT_ID]}

User : $user
Server : $server
=================================================================

EOT
	read -p "Are you sure you want synchronize this version to production ? (y/n)" CONT
	if [ "$CONT" == "y" -o "$CONT" == "" ]; then
		sync ${jenkins[$PROJECT_ID]} $user $server ${remote_dir[$PROJECT_ID]}
	fi
else
	echo "Project $PROJECT_ID doesnt exists !"
fi
