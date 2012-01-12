#require 'thinking_sphinx/deploy/capistrano'

set :application, "boi-cms"
set :repository,  "git://github.com/srerickson/boi-cms.git"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache

set :scm, :git

set :keep_releases, 5

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "capistrano"
set :use_sudo, false

role :web, "limn.it"                          # Your HTTP server, Apache/etc
role :app, "limn.it"                          # This may be the same as your `Web` server
role :db,  "limn.it", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"


#before "deploy:update_code", "deploy:stop_thinking_sphinx"

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:restart"
after  "deploy:bundle_gems", "deploy:start_thinking_sphinx"


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :bundle_gems do 
    run "ln -s #{deploy_to}/shared/vendor/gems #{deploy_to}/current/vendor/gems"
    run "cd #{deploy_to}/current && bundle install vendor/gems"
  end
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_sphinx_indexes, :roles => [:app] do
    #run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end

  task :stop_thinking_sphinx, :roles => [:app] do
    run "cd #{deploy_to}/current && bundle exec rake ts:stop"
  end

  task :start_thinking_sphinx, :roles => [:app] do
    run "cd #{deploy_to}/current && bundle exec rake ts:rebuild"
  end

end


task :pull_db do
  taps_user = `uuidgen`.strip
  taps_pass = `uuidgen`.strip

  run "nohup #{deploy_to}/taps_ctrl.sh start #{taps_user} #{taps_pass} > #{deploy_to}/taps.log 2>&1 ", :pty => true
  set(:user) do
    Capistrano::CLI.ui.ask "Give me local DB user: "
  end
  set(:pass) do
    Capistrano::CLI.ui.ask "Give me local DB pass: "
  end
  system("bundle exec taps pull mysql2://#{user}:#{pass}@localhost/boi http://#{taps_user}:#{taps_pass}@limn.it:5000")
  run "#{deploy_to}/taps_ctrl.sh stop"
end

