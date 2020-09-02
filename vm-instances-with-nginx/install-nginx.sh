#! /bin/bash

sudo apt-get install nginx-light -y
echo "<htm>
  <head>
    <title>My Nginx server</title>
  </head>
  <body>
    <h1>Nginx Server</h1>
    <p>
      Hi from Google Cloud Expert
    </p>
  </body>
</html>
" > /var/www/html/index.nginx-debian.html