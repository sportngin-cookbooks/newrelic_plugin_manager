node[:newrelic][:plugins].each do |plugin_name, attributes|
    newrelic_plugin_manager_plugin_agent plugin_name do
    license_key       node[:newrelic][:license_key]
    plugin_path       attributes[:plugin_path]
    plugin_version    attributes[:plugin_version]
    download_url      attributes[:download_url]
    config            attributes[:config]
  end
end
