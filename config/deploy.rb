set :application, "boi-cms"
set :repository,  "git://github.com/srerickson/boi-cms.git"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache

set :scm, :git

set :keep_releases, 5

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "www-data"
set :use_sudo, false

role :web, "thatwhich.net"                          # Your HTTP server, Apache/etc
role :app, "thatwhich.net"                          # This may be the same as your `Web` server
role :db,  "thatwhich.net", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"


after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:restart"


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :bundle_gems do 
    run "cd #{deploy_to}/current && bundle install vendor/gems"
  end
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
