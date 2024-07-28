
# Base Image: Start with a Debian image with Nginx pre-installed
FROM debian:latest

# Update the system
RUN apt-get update && apt-get upgrade -y

# Install required packages
RUN apt-get install -y nginx postgresql postgresql-contrib git

# Nginx Configuration (Optional but Recommended)
# Replace the default Nginx config if you have a custom one
# COPY nginx.conf /etc/nginx/sites-available/default

# Create a directory for web files and grant permissions
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

# Set up PostgreSQL
# Create a user and database
RUN service postgresql start && \
    su - postgres -c "psql -c \"CREATE USER app_user WITH PASSWORD 'your_password';\"" && \
    su - postgres -c "psql -c \"CREATE DATABASE app_db OWNER app_user;\"" && \
    service postgresql stop

# Expose Ports
EXPOSE 80
EXPOSE 5432

# Define Volumes for Persistence
VOLUME /var/www/html

# Entrypoint Script (Custom Script to Handle Startup and Github Integration)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
