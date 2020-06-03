gem_package 'newrelic_plugin' do
  version node[:newrelic][:newrelic_plugin][:version]
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
