# VerDZ - Gardening and Afforestation API

**VerDZ** is an API designed for gardening, afforestation, and greening projects, aimed at making Algeria a greener country. It is built using Laravel for the backend and designed to support a wide range of gardening and environmental initiatives.

## Getting Started

Before you begin, make sure your system meets the following prerequisites:

### Prerequisites

- **Git**: Version control system for managing code.
- **PHP**: Version 8.1 or later.
- **MySQL/MariaDB**: Version 10.4.21 or later.
- **Node.js**: Version 22.7.0 or later.
- **npm**: Version 10.8.3 or later, or **Yarn**: Version 1.22.22.

Ensure that you have these tools installed and properly configured on your system.

### Clone the Project

You can obtain the VerDZ API project by either cloning the repository using Git or downloading the ZIP file from GitHub:

- **Clone with Git**:
  ```shell
  git clone https://github.com/D-Redouane/verdz-api.git
  ```

- **Download ZIP**: 
  Go to the GitHub repository page and click the green "Code" button, then select "Download ZIP". Extract the ZIP file to a directory of your choice.

### Setup the Project

After cloning or extracting the project, follow the setup instructions below based on your operating system.

#### Windows

1. **Navigate to the project directory**:
   ```shell
   cd verdz-api
   ```

2. **Run the setup batch file** (if available):
   ```shell
   verdz_setup.bat
   ```

#### Linux

1. **Navigate to the project directory**:
   ```shell
   cd verdz-api
   ```

2. **Run the setup shell script** (if available):
   ```shell
   bash setup_verdz_linux.sh
   ```

## Installation

Follow the steps below to set up the VerDZ project on your local machine.

### Step 1: Clone the Project

If you haven't done so already, clone the project repository using Git or download the ZIP file as described in the "Getting Started" section.

### Step 2: Install Dependencies

Navigate to the project directory and install the required dependencies using Composer and npm:

```shell
cd verdz-api
composer install
npm install
```

### Step 3: Configure .env File

Copy the `.env.example` file and name it `.env`. Use the following command in the terminal:

```shell
cp .env.example .env
```

Generate a key for your application by running the following command:

```shell
php artisan key:generate
```

Set the appropriate values for `DB_DATABASE`, `DB_USERNAME`, and `DB_PASSWORD` in the `.env` file to connect the application to your MySQL database.

### Step 4: Create Symbolic Link for Storage

Create a symbolic link from `public/storage` to `storage/app/public`:

```shell
php artisan storage:link
```

### Step 5: Run Migrations

Run the database migrations to create the necessary tables:

```shell
php artisan migrate
```

### Step 6: Run Seed

Run the database seed to populate the database with default data:

```shell
php artisan db:seed
```

### Step 7: Build Vue.js Assets (Optional for Frontend)

If the project includes a frontend, compile the assets:

```shell
npm run dev
```

### Step 8: Start the Server

Start the Laravel development server by running the following command:

```shell
php artisan serve
```

### Step 9: Access the API

To access the VerDZ API, open your browser or use an API client like Postman to visit:
`http://127.0.0.1:8000`

## Quick Setup and Run

To quickly set up and run the VerDZ API, you can use the following one-liner command (Windows batch file format):

```bash
@echo off && git clone https://github.com/D-Redouane/verdz-api.git & cd verdz-api & composer install & npm install & copy .env.example .env & php artisan key:generate & php artisan storage:link & php artisan migrate & php artisan db:seed & start cmd /k "php artisan serve" & start cmd /k "npm run dev"
```

Or for Linux (bash script format):

```bash
#!/bin/bash
git clone https://github.com/D-Redouane/verdz-api.git
cd verdz-api
composer install
npm install
cp .env.example .env
php artisan key:generate
php artisan storage:link
php artisan migrate
php artisan db:seed
npm run dev &
php artisan serve
```

## Contributors

- [DADDIOUAMER Redouane](https://github.com/D-Redouane)

---

<div align="center">   
    <img src="./public/verdz.png" width="200">
    <p>&copy; 2024 VerDZ, All rights reserved</p> 
</div>