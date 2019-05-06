# config valid for current version and patch releases of Capistrano
lock "~> 3.10.0"

set :application, 'raana'
set :repo_url, "git@bitbucket.org:novahub/besm.git"
set :stages, ["staging", "production"]
set :deploy_via,      :remote_cache
set :deploy_to,       "~/apps/#{fetch(:application)}"
set :ssh_options, { :forward_agent => true }

namespace :custom do
  task :setup_environment_then_start_server do
    on roles(:deploy) do |host|
      execute "cp #{deploy_to}/shared/config/database.yml #{deploy_to}/current/config/"
      execute "cp #{deploy_to}/shared/config/puma.rb #{deploy_to}/current/config/"
      puts "================Load Ruby on Rails, migrate DB then start server===================="
      execute "source ~/.bash_profile && cd #{deploy_to}/current && ln -s $(readlink ~/apps/raan/fe/current) public && bundle install && bundle exec rake db:migrate && bundle exec pumactl -F config/puma.rb restart"
    end
  end
end

after "deploy:finishing", "custom:setup_environment_then_start_server"