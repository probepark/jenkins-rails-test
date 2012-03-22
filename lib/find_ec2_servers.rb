require 'fog'
require 'singleton'

class Ec2Servers
    include Singleton

    def initialize
        @servers = Fog::Compute.new({
            :provider => 'AWS',
        }).servers
        puts "servers #{@servers}"
    end

    def has_tag?(server, tag_name, tag_value)
        server_tag_value = server.tags && server.tags.member?(tag_name.to_s) && server.tags[tag_name.to_s]
        puts "checking tags: #{server.tags}, #{tag_name}, #{tag_value}, #{server_tag_value}"
        return true if server_tag_value.to_s == tag_value.to_s
        return server_tag_value && server_tag_value.split(',').member?(tag_value.to_s)
    end

    def find_ec2_servers(options = {})
        # find all web servers in this stage
        puts @servers
        servers = @servers.find_all { |server|
            has_tag?(server, :stage, options[:stage]) &&
            has_tag?(server, :roles, options[:role]) &&
            has_tag?(server, :app, options[:app])
        }.map(&:dns_name)
        puts "Servers:"
        puts servers
        servers
    end

end
