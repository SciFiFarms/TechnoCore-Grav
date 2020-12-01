
sleep 5
echo "MADE IT!!!!"

bin/gpm install learn2-git-sync quark page-toc
bin/plugin login new-user --user "$ADMIN_USER" --password "$(cat /run/secrets/admin_password)" --email "$ADMIN_EMAIL" --fullname "Administrator" -P a 
echo "Done"