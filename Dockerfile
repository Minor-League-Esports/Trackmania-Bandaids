# Base Image: Start with a Debian image with Nginx pre-installed
FROM debian:latest

# Update the system
RUN apt-get update && apt-get upgrade -y

# Install required packages
RUN apt-get install -y nginx git

# Nginx Configuration (Optional but Recommended)
# Replace the default Nginx config if you have a custom one
# COPY nginx.conf /etc/nginx/sites-available/default

# Create a directory for web files and grant permissions
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

# Expose Ports
EXPOSE 80

# Define Volumes for Persistence
VOLUME /var/www/html

# Entrypoint Script (Custom Script to Handle Startup and Github Integration)
COPY web/ /var/www/html
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
