# yum_package 'gcc'
# yum_package 'ruby-devel'
gem_package 'newrelic_plugin' do
  version node[:newrelic][:newrelic_plugin][:version]
end

group node[:newrelic][:user][:group] do
  action :create
end

user node[:newrelic][:user][:name] do
  gid node[:newrelic][:user][:group]
  action :create
end

file "/home/#{node[:newrelic][:user][:name]}/.bashrc" do
  content "export PATH=/usr/local/bin:$PATH"
  owner node[:newrelic][:user][:name]
  group node[:newrelic][:user][:group]
  mode 0644
  action :create_if_missing
end

ruby_block "add /usr/local/bin to /home/#{node[:newrelic][:user][:name]}/.bashrc" do
  block do
    file = Chef::Util::FileEdit.new("/home/#{node[:newrelic][:user][:name]}/.bashrc")
    file.insert_line_if_no_match("\/usr\/local\/bin", "export PATH=/usr/local/bin:$PATH")
    file.write_file
  end
end

ruby_block "testing things" do
  block do
    Chef::Log.info "WHOAMI"
    Chef::Log.info `whoami`
    Chef::Log.info "GEM_HOME"
    Chef::Log.info `$GEM_HOME`
    Chef::Log.info "GEM_PATH"
    Chef::Log.info `$GEM_PATH`
    Chef::Log.info "PATH"
    Chef::Log.info `$PATH`
  end
end

node[:newrelic][:plugins].each do |plugin_name, attributes|
    newrelic_plugin_manager_plugin_agent plugin_name do
    license_key       node[:newrelic][:license_key]
    plugin_path       attributes[:plugin_path]
    plugin_version    attributes[:plugin_version]
    plugin_type       attributes[:plugin_type]
    download_url      attributes[:download_url]
    config            attributes[:config]
  end
end
