# config valid for current version and patch releases of Capistrano
lock "~> 3.20.0"

# set :application, "evoting"
# set :application, "e-voting"
# set :application, "coop_tech"
# set :application, "sacred_heart"
set :application, "st_vincent"
set :repo_url, "git@github.com:AnsellGabriel/evoting.git"
set :rails_env, "production" #
set :branch, "main" #

# Deploy to the user's home directory
set :deploy_to, "/home/deploy/#{fetch :application}"

set :rbenv_type, :user #
set :rbenv_ruby, "3.2.2" #
set :rbenv_path, "/home/deploy/.rbenv" #

# Configure mysql2 build options for production server
# This helps mysql2 find MySQL development libraries on the server
before 'bundler:install', 'bundler:config_mysql2'

namespace :bundler do
  desc 'Configure mysql2 build options to find MySQL libraries'
  task :config_mysql2 do
    on roles(:app) do
      within release_path do
        # Try to configure mysql2 to find MySQL libraries
        # First try with mysql_config if available
        mysql_config_path = capture("which mysql_config 2>/dev/null || echo ''").strip
        if mysql_config_path && !mysql_config_path.empty?
          info "Configuring mysql2 with mysql_config: #{mysql_config_path}"
          execute :bundle, "config build.mysql2 --with-mysql-config=#{mysql_config_path}"
        elsif test("[ -d /usr/include/mysql ]")
          info "Configuring mysql2 with MySQL libraries in /usr"
          execute :bundle, "config build.mysql2 --with-mysql-dir=/usr"
        else
          warn "WARNING: MySQL development libraries may not be installed on the server."
          warn "Please install MySQL development libraries:"
          warn "  Ubuntu/Debian: sudo apt-get install libmysqlclient-dev"
          warn "  CentOS/RHEL: sudo yum install mariadb-devel"
          warn "Attempting to build mysql2 with default configuration..."
          execute :bundle, "config build.mysql2 --with-mysql-dir=/usr"
        end
      end
    end
  end
end

append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", ".bundle", "public/system", "public/uploads"

# append :linked_files,  'config/credentials/production.key'
append :linked_files, "config/master.key", "config/database.yml", "config/secrets.yml"

namespace :deploy do #
  namespace :check do #
    before :linked_files, :set_keys do #
      on roles(:app), in: :sequence, wait: 10 do #
        #   unless test("[ -f #{shared_path}/config/master.key ]")  #
        #     upload! 'config/master.key', "#{shared_path}/config/master.key"  #
        #   end  #
        unless test("[ -f #{shared_path}/config/master.key ]") #
          upload! "config/master.key", "#{shared_path}/config/master.key"  #
        end  #
        unless test("[ -f #{shared_path}/config/secrets.yml ]") #
          upload! "config/secrets.yml", "#{shared_path}/config/secrets.yml" #
        end  #
        unless test("[ -f #{shared_path}/config/database.yml ]") #
          upload! "config/database.yml", "#{shared_path}/config/database.yml"  #
        end  #
        # unless test("[ -f #{shared_path}/config/application.yml ]")  #
        #   upload! 'config/application.yml', "#{shared_path}/config/application.yml"  #
        # end  #
        # unless test("[ -f #{shared_path}/config/initializers/meilisearch.rb ]")  #
        #   upload! 'config/initializers/meilisearch.rb', "#{shared_path}/config/initializers/meilisearch.rb"  #
        # end  #
      end
    end
  end
end #
# Only keep the last 5 releases to save disk space
set :keep_releases, 5

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
