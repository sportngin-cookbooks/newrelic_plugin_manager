node[:newrelic][:plugins].each do |plugin_name, attributes|
    plugin_agent      plugin_name do
    license_key       node[:newrelic][:license_key]
    plugin_version    attributes[:plugin_version]
    download_url      attributes[:download_url]
    config            attributes[:config]
  end
end
