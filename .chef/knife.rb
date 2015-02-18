# See https://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "mattstratton"
client_key               "#{current_dir}/mattstratton.pem"
validation_client_name   "mattstratton-validator"
validation_key           "#{current_dir}/mattstratton-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/chicago-alm-demo"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
