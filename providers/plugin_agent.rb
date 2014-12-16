def install_agent
  # verify ruby dependency
  verify_ruby '#{new_resouce.plugin_name.split(" ").map(&:capitalize).join(" ")} Plugin'

  verify_license_key new_resource.license_key

  install_plugin 'newrelic_#{new_resource.plugin_name}_plugin' do
    install_path     new_resource.install_path
    plugin_path      new_resource.plugin_path
    plugin_version   new_resource.plugin_version
    download_url     new_resource.download_url 
    user             new_resource.user
  end

  # newrelic template
  template "#{new_resource.plugin_path}/config/newrelic_plugin.yml" do
    source 'newrelic_plugin.yml.erb'
    action :create
    owner new_resource.user
    variables ({
      :license_key => new_resource.license_key,
      :plugin_name => new_resource.plugin_name,
      :config => new_resource.config
      })
    notifies :restart, "service[newrelic-#{new_resouce.plugin_name}-plugin]"
  end

  # install bundler gem and run 'bundle install'
  bundle_install do
    path new_resource.plugin_path
    user new_resource.user
  end
end

def start_agent
  # install init.d script and start service
  plugin_service "newrelic-#{new_resouce.plugin_name}-plugin" do
    daemon          './newrelic_#{new_resouce.plugin_name}_agent'
    daemon_dir      new_resource.plugin_path
    plugin_name     new_resource.plugin_name
    plugin_version  new_resource.plugin_version
    user            new_resource.user
    run_command     'bundle exec'
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