@echo off
composer install & npm install & copy .env.example .env & php artisan key:generate & php artisan jwt:secret & php artisan migrate & php artisan db:seed & php artisan storage:link & start cmd /k "php artisan serve" & start cmd /k "npm run dev"
