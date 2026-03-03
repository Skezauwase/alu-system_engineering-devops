#!/usr/bin/env bash
# Deploys the beautiful 404 page to the web server

# Update and install nginx if not already installed
sudo apt-get update
sudo apt-get -y install nginx
sudo ufw allow 'Nginx HTTP'

# Ensure index page exists
echo "Holberton School" | sudo tee /var/www/html/index.html > /dev/null

# Copy the beautiful 404 HTML file to web root
sudo cp 5-design_a_beautiful_404_page.html /var/www/html/404.html

# Set proper permissions
sudo chmod 644 /var/www/html/404.html

# Check if error_page directive already exists, if not add it
if ! sudo grep -q "error_page 404" /etc/nginx/sites-enabled/default; then
    sudo sed -i '/server_name _;/a \\terror_page 404 /404.html;' /etc/nginx/sites-enabled/default
fi

# Verify nginx configuration is valid
sudo nginx -t

# Restart nginx
sudo service nginx restart

echo "✓ 404 page deployed successfully!"
echo "Visit http://skeza.tech/abc to see your custom 404 page"
