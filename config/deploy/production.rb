load 'lib/find_ec2_servers'

servers = Ec2Servers.instance

role :app do
    servers.find_ec2_servers({
        :stage => :production,
        :role => :app,
        :app => fetch(:application),
    })
end

role :web do
    servers.find_ec2_servers({
        :stage => :production,
        :role => :web,
        :app => fetch(:application),
    })
end

role :db, :primary => true do
    servers.find_ec2_servers({
        :stage => :production,
        :role => :db,
        :app => fetch(:application),
    })
end
