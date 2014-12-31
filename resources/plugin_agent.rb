actions        :install, :start
default_action [:install, :start]

attribute :plugin_name,       :kind_of => String,        :name_attribute => true
attribute :plugin_version,    :kind_of => String,        :required => true
attribute :license_key,       :kind_of => String,        :required => true
attribute :download_url,      :kind_of => String,        :required => true
attribute :config,            :kind_of => [Hash,Array],  :required => true
attribute :options,           :kind_of => String,        :required => false
attribute :plugin_path,       :kind_of => String,        :required => true
attribute :plugin_type,       :kind_of => String,        :required => true
attribute :install_path,      :kind_of => String,        :default => node[:newrelic][:install_path]
attribute :user,              :kind_of => String,        :default => node[:newrelic][:user][:name]
attribute :group,             :kind_of => String,        :default => node[:newrelic][:user][:group]

attr_accessor :exists
