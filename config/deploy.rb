set :application, "railsjam.com"
set :repository,  "git://github.com/mifan/rails_jam.git"


set :scm, :git
set :user, "stoneworm"
set :use_sudo, false


set :deploy_to, "/home/#{user}/#{application}"

role :app, "railsjam.com"
 


# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app do   
    run "cp -f #{shared_path}/config/database.yml #{release_path}/config/"
    run "ln -s #{shared_path}/.bundle #{release_path}/.bundle"
  end
end