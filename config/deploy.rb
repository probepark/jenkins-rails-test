set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :user, "ubuntu"
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")] 
ssh_options[:forward_agent] = true

set :application, "jenkins-rails-test"

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:gregory144/jenkins-rails-test.git"  # Your clone URL
set :scm, "git"
#set :user, "deployer"  # The server's user for deploys
set :scm_passphrase, ""  # The deploy user's password
set :deploy_via, :remote_cache
set :deploy_env, 'production'

# passenger set up:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

desc "Watch the production log on the application server."
task :watch_logs, :role => [:app] do
  log_file = "#{shared_path}/log/production.log"
  run "tail -f #{log_file}" do |channel, stream, data|
    puts data if stream == :out 
    if stream == :err 
      puts "[Error: #{channel[:host]}] #{data}"
      break
    end
  end
end
