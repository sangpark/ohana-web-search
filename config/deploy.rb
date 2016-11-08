# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'radical'
set :repo_url, 'git@github.com:sangpark/ohana-web-search.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/rails/radical'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
set :ssh_options,    { :forward_agent => true, :paranoid => false }

# Default value for :linked_files is []
append :linked_files, 'config/settings.yml', 'config/application.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
set :default_env, {
  PATH: '/usr/local/rvm/gems/ruby-2.3.1/bin:$PATH'
}
set :bundle_env_variables, {
  PATH: '/usr/local/rvm/gems/ruby-2.3.1/bin:$PATH'
}

# Default value for keep_releases is 5
set :keep_releases, 5

set :rvm_type, :system
set :rvm_ruby_version, '2.3.1'

# use the traditional "touch tmp/restart.txt"
set :passenger_restart_with_touch, true

# NOTE: cscharf:
# needed to run this on the server to get bundle to work:
#   /usr/local/rvm/bin/rvm 2.3.1 do gem install bundler

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

task :env do
  on roles(:app) do
    execute "/usr/local/rvm/bin/rvm 2.3.1 do gem env"
  end
end
