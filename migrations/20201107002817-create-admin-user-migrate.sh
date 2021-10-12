
sleep 5
cd /app/grav-admin/
/app/grav-admin/bin/plugin login new-user --user "$ADMIN_USER" --password "$(cat /run/secrets/admin_password)" --email "$ADMIN_EMAIL" --fullname "Administrator" -P a
