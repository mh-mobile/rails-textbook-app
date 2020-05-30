# frozen_string_literal: true

lock "~> 3.14.0"

set :application, "book_app"
set :repo_url, "git@github.com:mh-mobile/rails-textbook-app.git"
set :branch, "feature/postgres"
set :deploy_to, "/var/www/#{fetch(:application)}_#{fetch(:stage)}"
set :user, "deploy"
set :deploy_via, :remote_cache

# rbenv
set :rbenv_type, :user
set :rbenv_ruby, File.read(".ruby-version").strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all
append :rbenv_map_bins, "puma", "pumactl"

# linked
append :linked_files, "config/database.yml", "config/master.key", ".env"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads"

# nginx
set :nginx_server_name, "bootmbyk.work"
set :nginx_use_ssl, true
set :nginx_ssl_certificate, "/etc/letsencrypt/live/#{fetch(:nginx_server_name)}/fullchain.pem"
set :nginx_ssl_certificate_key, "/etc/letsencrypt/live/#{fetch(:nginx_server_name)}/privkey.pem"

# postgres
set :pg_without_sudo, false
set :pg_host, "localhost"
set :pg_database, "#{fetch(:application)}_#{fetch(:stage)}"
set :pg_password, ENV["BOOKAPP_DATABASE_PASSWORD"]
set :pg_username, "#{fetch(:user)}"
set :pg_extensions, ['citext','hstore']
set :pg_encoding, 'UTF-8'
set :pg_pool, '100'

namespace :deploy do
  desc "upload important file"
  task :upload do
    on roles(:app) do
      sudo :mkdir, "-p", "#{shared_path}/config"
      sudo %[chown -R #{fetch(:user)}:#{fetch(:user)} #{deploy_to}]
      sudo :mkdir, "-p", "/etc/nginx/sites-enabled"
      sudo :mkdir, "-p", "/etc/nginx/sites-available"

      upload!("config/database.yml", "#{shared_path}/config/database.yml")
    end
  end

  before :starting, :upload
  before "check:linked_files", "puma:nginx_config"
  after "deploy:published", "nginx:restart"
end

Rake::Task["nginx:enable_site"].clear_actions
Rake::Task["nginx:disable_site"].clear_actions

namespace :nginx do
  desc "Enable nginx site"
  task :enable_site do
    on roles fetch(:nginx_roles) do
      sudo :ln, "-sf",
        "#{fetch(:nginx_path)}/sites-available/#{fetch(:application)}_#{fetch(:stage)}",
        "#{fetch(:nginx_path)}/sites-enabled/#{fetch(:application)}_#{fetch(:stage)}"
    end
    invoke :'nginx:reload'
  end

  desc "Disable nginx site"
  task :disable_site do
    on roles fetch(:nginx_roles) do
      config_link = "#{fetch(:nginx_path)}/sites-enabled/#{fetch(:application)}_#{fetch(:stage)}"
      sudo :unlink, config_link if test "[ -f #{config_link} ]"
    end
    invoke :'nginx:reload'
  end
end
