#!/bin/sh

# Set the PHP file to the current directory
PHP_FILE=$(pwd)/webconsole.php
echo $PHP_FILE

# Set the port number to use (e.g. 8080)
PORT=8080

# Start the PHP development server
php -S localhost:$PORT -t "$(pwd)"

# Open the PHP file in the default browser
# open "http://localhost:$PORT/index.php"
