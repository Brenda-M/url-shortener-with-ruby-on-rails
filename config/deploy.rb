# config valid for current version and patch releases of Capistrano
lock "~> 3.18.0"

# set :application, "snappy"
# set :repo_url, "git@github.com:Brenda-M/url-shortener-with-ruby-on-rails.git"
# set :deploy_to, '/home/dev/snappy'
# set :branch, :main
# set :pty, true
# set :linked_files, %w{config/database.yml config/application.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
# set :keep_releases, 5
# set :rvm_type, :user
# set :rvm_ruby_version, 'ruby-3.0.0'

# set :puma_rackup, -> { File.join(current_path, 'config.ru') }
# set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
# set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
# set :puma_conf, "#{shared_path}/puma.rb"
# set :puma_access_log, "#{shared_path}/log/puma_error.log"
# set :puma_error_log, "#{shared_path}/log/puma_access.log"
# set :puma_role, :app
# set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
# set :puma_threads, [0, 8]
# set :puma_workers, 0
# set :puma_worker_timeout, nil
# set :puma_init_active_record, true
# set :puma_preload_app, false
set :application, 'snappy'
set :repo_url,  "git@github.com:Brenda-M/url-shortener-with-ruby-on-rails.git"
set :branch, :main
set :deploy_to, '/home/dev/snappy'
set :pty, true
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5
