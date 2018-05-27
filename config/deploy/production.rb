# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{towedcarinfo@nathan-hale.zagaja.com}
role :web, %w{towedcarinfo@nathan-hale.zagaja.com}
role :db,  %w{towedcarinfo@nathan-hale.zagaja.com}


# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

# server 'nathan-hale.zagaja.com', user: 'rails', roles: %w{web app}, my_property: :my_value


set :passenger_restart_command, 'passenger-config restart-app'
set :rvm_custom_path, '/usr/share/rvm'
set :rvm_ruby_version, '2.4.4'
