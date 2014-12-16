actions        :install_and_start, :install, :start
default_action :install_and_start

attribute :plugin_name,       :kind_of => String, :name_attribute => true
attribute :plugin_version,    :kind_of => String, :required => true
attribute :license_key,       :kind_of => String, :required => true
attribute :download_url,      :kind_of => String, :required => true
attribute :config,            :kind_of => Hash,   :required => true
attribute :plugin_path,       :kind_of => String, :required => true
attribute :install_path,      :kind_of => String, :default => node[:newrelic][:install_path]
attribute :user,              :kind_of => String, :default => node[:newrelic][:user][:name]

attr_accessor :exists
