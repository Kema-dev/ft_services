echo "\nstarting autoindex switch ...\n"

if cat /etc/nginx/sites-available/mysite | grep " on"
	then cat /tmp/nginx-conf-off > /etc/nginx/sites-available/mysite
	else cat /tmp/nginx-conf-on > /etc/nginx/sites-available/mysite
fi

ln -s /etc/nginx/sites-available/mysite /etc/nginx/sites-enabled/mysite

service nginx reload
service nginx restart
service nginx status

echo "\nautoindex switch finished\n"