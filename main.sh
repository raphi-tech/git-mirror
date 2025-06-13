# Import configuration variables
. .config

read -p "Which authentication method do you want to use? [ssh] or [http]: " auth_method 

while true
do
    if [ "$auth_method" == "ssh" ]; then
	url_origin_repo=$url_ssh_origin_repo
	url_target_repo=$url_ssh_target_repo
	break
    elif [ "$auth_method" == "http" ]; then
	read -p "Do you use git credential manager? [y] or [n]: " uses_manager
	while true
	do
	    if [ "$uses_manager" == "y" ]; then
		url_origin_repo=$url_http_origin_repo
		url_target_repo=$url_http_target_repo
		break
	    elif [ "$uses_manager" == "n" ]; then
		url_origin_repo=$url_http_auth_origin_repo
		url_target_repo=$url_http_auth_target_repo
		break
	    else
		read -p "Please provide a valid input [y] or [n]: " uses_manager
	    fi
	done
	break
    else
	read -p "Please provide a valid input [ssh] or [http]: " auth_method
    fi
done

git clone --mirror "$url_origin_repo" "$path_to_cloned_repo"

# Check if local repo folder was successfully created
git ls-remote "$path_to_cloned_repo" -q

if [ $? -eq 0 ]; then
    cd "$path_to_cloned_repo"

    git remote set-url --push origin "$url_target_repo"

    # Cron job
    (crontab -l ; echo "$cron_job cd $path_to_script && bash update_repository_mirror.sh >> $path_to_log/cron_job.log 2>&1") | crontab -
else
    echo "The local repository folder has not been created, please provide a valid authentication method."
fi
