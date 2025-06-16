# Import configuration variables
. .config

# User defined origin repo authentication
read -p "Which authentication method do you want to use for the origin repo? [ssh] or [http]: " auth_method_origin

while true
do
    if [ "$auth_method_origin" == "ssh" ]; then
	url_origin_repo=$url_ssh_origin_repo
	break
    elif [ "$auth_method_origin" == "http" ]; then
	read -p "Do you use git credential manager? [y] or [n]: " uses_manager_origin
	while true
	do
	    if [ "$uses_manager_origin" == "y" ]; then
		url_origin_repo=$url_http_origin_repo
		break
	    elif [ "$uses_manager_origin" == "n" ]; then
		url_origin_repo=$url_http_auth_origin_repo
		break
	    else
		read -p "Please provide a valid input [y] or [n]: " uses_manager_origin
	    fi
	done
	break
    else
	read -p "Please provide a valid input [ssh] or [http]: " auth_method_origin
    fi
done

# User defined target repo authentication
read -p "Which authentication method do you want to use for the target repo? [ssh] or [http]: " auth_method_target 
while true
do
    if [ "$auth_method_target" == "ssh" ]; then
	url_target_repo=$url_ssh_target_repo
	break
    elif [ "$auth_method_target" == "http" ]; then
	read -p "Do you use git credential manager? [y] or [n]: " uses_manager_target
	while true
	do
	    if [ "$uses_manager_target" == "y" ]; then
		url_target_repo=$url_http_target_repo
		break
	    elif [ "$uses_manager_target" == "n" ]; then
		url_target_repo=$url_http_auth_target_repo
		break
	    else
		read -p "Please provide a valid input [y] or [n]: " uses_manager_target
	    fi
	done
	break
    else
	read -p "Please provide a valid input [ssh] or [http]: " auth_method_target
    fi
done


# Create a bare mirrored clone of the origin repo
git clone --mirror "$url_origin_repo" "$absolute_path_to_cloned_repo"

# Check if local repo folder was successfully created (returns 0 if successful)
git ls-remote "$absolute_path_to_cloned_repo" -q

if [ $? -eq 0 ]; then
    cd "$absolute_path_to_cloned_repo"

    # Set push location to mirror (target) repository:
    git remote set-url --push origin "$url_target_repo"

    # Cron job which updates the repository mirror through a Cronjob script
    (crontab -l ; echo "$cron_job cd $absolute_path_to_script && bash cronjob_script.sh") | crontab -
else
    echo "The local repository folder has not been created, please provide a valid authentication method."
fi
