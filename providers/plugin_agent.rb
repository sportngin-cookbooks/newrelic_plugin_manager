require 'json'

def install_agent
  current_resource = new_resource
  # verify ruby dependency
  verify_ruby "#{current_resource.plugin_name.split(" ").map(&:capitalize).join(" ")} Plugin"

  verify_license_key current_resource.license_key

  install_plugin "newrelic_#{current_resource.plugin_name}_plugin" do
    install_path     current_resource.install_path
    plugin_path      current_resource.plugin_path
    plugin_version   current_resource.plugin_version
    download_url     current_resource.download_url 
    user             current_resource.user
    group            current_resource.group
  end

  # newrelic template
  template "#{current_resource.plugin_path}/config/newrelic_plugin.yml" do
    source 'newrelic_plugin.yml.erb'
    action :create
    owner current_resource.user
    group current_resource.group
    variables ({
      :license_key => current_resource.license_key,
      :config => {
        "agents" => {
          "#{current_resource.plugin_name}" => 
            JSON.parse(current_resource.config.to_json) 
          } 
        }.to_yaml.gsub("---\n", '')
      })
    notifies :restart, "service[newrelic-#{current_resource.plugin_name}-plugin]"
  end

  # install bundler gem and run 'bundle install'
  bundle_install do
    path current_resource.plugin_path
    user current_resource.user
    group current_resource.group
  end
end

def start_agent
  current_resource = new_resource
  
  # install init.d script and start service
  plugin_service "newrelic-#{current_resource.plugin_name}-plugin" do
    daemon          "#{current_resource.plugin_path}/newrelic_#{current_resource.plugin_name}_agent"
    daemon_dir      current_resource.plugin_path
    plugin_name     current_resource.plugin_name
    plugin_version  current_resource.plugin_version
    user            current_resource.user
    group           current_resource.group
    run_command     '/usr/local/bin/bundle exec'
  end
end

action :install_and_start do
  install_agent
  start_agent
end

action :install do
  install_client
end

action :configure do
  start_agent
end