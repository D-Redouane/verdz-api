#!/bin/bash


# Install Composer dependencies
sudo composer install

# Install NPM dependencies
sudo npm install

# Copy environment file
sudo cp .env.example .env

# Generate application key
sudo php artisan key:generate

# Generate JWT secret (if you're using JWT)
sudo php artisan jwt:secret

# Run database migrations
sudo php artisan migrate

# Seed the database (if needed)
sudo php artisan db:seed

#  link storage folder
sudo php artisan storage:link

# Start the Laravel application
sudo php artisan serve --host=0.0.0.0 --port=80 &

# Start the frontend build process (e.g., npm run dev)
sudo npm run dev
