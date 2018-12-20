#!/bin/bash
echo "Type in the domain name you wish to download (e.g. rescuepets.com.au)"
read domain

mkdir -p ~/Desktop/$domain-backups

if [ -z "$domain" ] 
then
	echo "You must provide a domain name."
	exit 1
fi

echo "Enter the username"
read user

if [ -z "$user" ]
then
	echo "You must provide a username."
fi

echo "Going to download from vps.$domain on user $user. Okay? (y/n)"
read confirm
if [ ! "y" = "$confirm" ]
then
	echo "Cancelling..."
	exit 1
fi

out=$domain-$(date +"%Y-%m-%d-%T").tar.gz
scp $user@vps.$domain:/home/$user/backup/data/*-latest.tar.gz ~/Desktop/$domain-backups/$out
ls -lth ~/Desktop/$domain-backups
echo "Finished. If no files are listed above, backup did not succeed"
echo "Your backup files are located at ~/Desktop/$domain-backups"
