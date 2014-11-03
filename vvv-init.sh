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
	echo "Downloading WP Core"
	wp core download 
	echo "Creating wp-config.php"
	wp core config --dbname="project_db" --dbuser=root --dbpass=root --dbhost="localhost" --dbprefix=wp_
	echo "Installing WordPress"
	wp core install --url=project.dev --title="Project" --admin_user=admin --admin_password=password --admin_email=demo@example.com
	echo "Installing Plugins"
	# EasyEngine plugins
	wp plugin install --activate w3-total-cache
	wp plugin install --activate nginx-helper
	
	#Probably will use on every site
	wp plugin install --activate custom-field-suite
	wp plugin install --activate better-wp-security
	wp plugin install --activate updraftplus
	wp plugin install --activate wordpress-seo
	wp plugin install --activate wpremote
	wp plugin install --activate admin-menu-editor
    wp plugin install --activate ninja-forms
	echo "Goodbye Dolly"
	wp plugin uninstall hello
	wp plugin uninstall akismet
	cd ..
fi

# The Vagrant site setup script will restart Nginx for us

echo "Finished vvv-init.sh";