# Import configuration variables
. .config

git clone --mirror "$origin_repo" ~/"$folder_name"

cd ~/"$folder_name"

git remote set-url --push origin "$target_repo"


# Cron job
(crontab -l ; echo "$cron_job") | crontab -
