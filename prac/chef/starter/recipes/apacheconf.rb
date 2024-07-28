package 'httpd'
service 'httpd' do
action [:enable, :start]
end

file '/var/www/html/index.html' do
content 'Welcome to Apache in Chef by GF'
end

