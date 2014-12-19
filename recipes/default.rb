gem_package 'newrelic_plugin' do
  version '1.3.1'
end

ruby_block "add /usr/local/bin to /etc/profile" do
  block do
    file = Chef::Util::FileEdit.new("/etc/profile")
    file.insert_line_if_no_match("\/usr\/local\/bin", "export PATH=/usr/local/bin:$PATH")
    file.write_file
  end
end

group node[:newrelic][:user][:group] do
  action :create
end

user node[:newrelic][:user][:name] do
  gid node[:newrelic][:user][:group]
  action :create
end

node[:newrelic][:plugins].each do |plugin_name, attributes|
    newrelic_plugin_manager_plugin_agent plugin_name do
    license_key       node[:newrelic][:license_key]
    plugin_path       attributes[:plugin_path]
    plugin_version    attributes[:plugin_version]
    download_url      attributes[:download_url]
    config            attributes[:config]
    plugin_type       attributes[:plugin_type]
  end
end
