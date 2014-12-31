user node[:newrelic][:user][:name] do
  action :create
end

group node[:newrelic][:user][:group] do
  append true
  members node[:newrelic][:user][:name]
  action :create
end