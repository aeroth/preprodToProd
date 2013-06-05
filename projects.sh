#!/bin/bash
user="username"
server="127.0.0.1"


workspace="/var/www/preprod/"

declare -A projects
declare -A paths
declare -A remote_dir

# CLIENT MANAGER
projects[0]="ProjectName"
jenkins[0]=$workspace'ClientManager/workspace/client_manager/'
remote_dir[0]="perfactivity/http/cm_test/"
