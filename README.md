###Newrelic Plugin Manager
The purpose of this cookbook is to easily install Newrelic plugins. It's based off of the official [newrelic_plugin](https://github.com/newrelic-platform/newrelic_plugins_chef) installer created by Newrelic. It differs from the offical installer in that it utilizes a LWRP eliminating the need to create a recipe for each plugin. 

###Attributes

`node[:newrelic][:license_key]` This is pretty self explanatory. It's also very necessary since plugins won't start without it.

`node[:newrelic][:install_path]`The directory that all plugins will be installed in, it defaults to `/opt/newrelic`

`node[:newrelic][:user][:name]` The user you want plugins to be run as, defaults to `root`

`node[:newrelic][:user][:group] ` The group you want the above user to belong to, also defaults ot `root`

`node[:newrelic][:plugins]` This is where you can describe the plugins you'd like to install.

###Usage
*Replace PLUGIN_NAME with the actual name of the plugin*

`node[:newrelic][:plugins][PLUGIN_NAME][:download_url]` The download url of the plugin, must be a tarball.
 
`node[:newrelic][:plugins][PLUGIN_NAME][:plugin_version]` The version of the plugin you'd like to install
 
`node[:newrelic][:plugins][PLUGIN_NAME][:plugin_type]` Can be either `ruby` or `java`

`node[:newrelic][:plugins][PLUGIN_NAME][:config]` Any configs necessary for the plugin to run

This cookbook also creates a LWRP that you can use in your recipes. To use it, just put something like this in your recipes:

```
  newrelic_plugin_manager_plugin_agent plugin_name do
    license_key       'license_key'       #String
    plugin_path       'plugin_path'       #String
    plugin_version    'plugin_version'    #String
    plugin_type       'plugin_type'       #String
    download_url      'download_url'      #String
    config            'config'            #Array of Hashes
  end
```


###Example Usage
The following would install both the `newrelic_example_plugin` and `newrelic_java_wikipedia_plugin`

    example:
      download_url: 'https://github.com/newrelic-platform/newrelic_example_plugin/archive/release/1.0.1.tar.gz'
      plugin_path: "#{node[:newrelic][:install_path]}/newrelic_example_plugin"
      plugin_version: '1.0.1'
      plugin_type: 'ruby'
      config:
        - hertz: 1000
          space:
            left: 'yes'
            right: 'now'
    wikipedia_java:
      download_url: 'https://github.com/newrelic-platform/newrelic_java_wikipedia_plugin/raw/master/dist/newrelic_wikipedia_plugin-2.0.0.tar.gz'
      plugin_path: "#{node[:newrelic][:install_path]}/newrelic_wikipedia_java_plugin"
      plugin_version: "2.0.0"
      plugin_type: 'java'
      options: '-Xmx128m'
      config:
        - name: "Wikipedia - English"
          host: "en.wikipedia.org"
        - name: "Wikipedia - French"
          host: "fr.wikipedia.org"
