x#! /bin/bash

sudo apt-get update
sudo apt-get install nginx-light -y
touch ~/index.html
echo '
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>The Google Cloud expert  nginx deployment</p>
<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
' > ~/index.html
sudo cp  ~/index.html /var/www/html/
sudo rm /var/www/html/index.nginx-debian.html
