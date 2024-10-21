@echo off
start "Server" /min cmd /k "php artisan serve"
start "Development" /min cmd /k "npm run dev"
