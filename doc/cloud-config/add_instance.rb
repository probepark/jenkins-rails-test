#!/usr/bin/ruby
require 'rubygems'
require 'fog'

# Set up a connection
fog = Fog::Compute.new(:provider => 'AWS')

server = fog.servers.bootstrap(
    :image_id => 'ami-baba68d3',
    :flavor_id => 'm1.small',
    :username => 'ubuntu',
    :key_name => 'greggross-test',
    :private_key_path => '~/.ssh/greggross-test.pem',
    :user_data => File.read('/home/gregory144/src/fog/combined-userdata.txt.gz'),
    :tags => { 'roles' => 'web,app,db', 'app' => 'jenkins-rails-test', 'stage' => 'staging' },
)

# wait for it to be ready to do stuff
#server.wait_for { print "."; ready? }

puts "Public IP Address: #{server.public_ip_address}"
puts "Private IP Address: #{server.private_ip_address}"
