#!/bin/sh
. .config

# Log the date and output with error messages from the script that updates the repository mirror
( echo -e "\n-- $(date '+%Y-%m-%d %H:%M:%S') --" && bash update_repository_mirror.sh ) >> $absolute_path_to_log/cron_job.log 2>&1
