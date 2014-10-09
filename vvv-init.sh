# Init script for VVV Auto Bootstrap Demo 1

echo "Commencing vvv-init.sh"

# Make a database, if we don't already have one
echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS project_db"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON project_db.* TO root@localhost IDENTIFIED BY 'root';"

# Download WordPress
if [ ! -d wp-core ]
then
	echo "Installing WordPress using WP CLI"
	mkdir wp-core
	cd wp-core
	wp core download 
	wp core config --dbname="project_db" --dbuser=root --dbpass=root --dbhost="localhost" --dbprefix=wp_
	wp core install --url=project.dev --title="Project" --admin_user=admin --admin_password=password --admin_email=demo@example.com
	wp plugin install custom-field-suite
	wp plugin install better-wp-security
	wp plugin install updraftplus
	wp plugin install wordpress-seo
	wp plugin install wpremote
	wp plugin install admin-menu-editor
	wp plugin uninstall hello
	wp plugin uninstall akismet
	cd ..
fi

# The Vagrant site setup script will restart Nginx for us

echo "Finished vvv-init.sh";
