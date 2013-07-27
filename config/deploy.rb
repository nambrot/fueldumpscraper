require "rvm/capistrano"
require 'bundler/capistrano'

set :application, "fueldumpscraper"
set :repository,  "git@github.com:/nambrot/fueldumpscraper"
set :deploy_to, "/home/fueldump/fueldumpscraper"
set :user, "fueldump"
set :branch, "master"
set :git_enable_submodules, 1
set :use_sudo, false
set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :ssh_options, { :forward_agent => true }
role :web, "bu.cloudapp.net"                          # Your HTTP server, Apache/etc
role :app, "bu.cloudapp.net"                          # This may be the same as your `Web` server
# role :db,  "bu.cloudapp.net:80", :primary => true # This is where Rails migrations will run
# role :db,  "bu.cloudapp.net:80"

set :rails_env, "production"
set :keep_releases, 3
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  desc "Symlink shared/* files"
    task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after "deploy:update_code", "deploy:symlink_shared"
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end