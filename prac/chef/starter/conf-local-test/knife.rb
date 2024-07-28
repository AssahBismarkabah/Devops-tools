current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                'bismark'
client_key               "#{current_dir}/chefadmin.pem"
validation_client_name   'myorg-validator'
validation_key           "#{current_dir}/myorg-validator.pem"
chef_server_url          'https://localhost/organizations/myorg'
#cookbook_path            ["#{current_dir}/../cookbooks"]
cookbook_path            ["#{ENV['HOME']}/Desktop/dev/Cloud-Lab/prac/chef"]
ssl_verify_mode :verify_none
