define :verify_user do
  if params[:name] == 'root'
    Chef::Application.fatal!("User must not be set as root")
  end
end