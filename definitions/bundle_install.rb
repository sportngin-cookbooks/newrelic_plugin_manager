define :bundle_install do
  # install bundler gem
  gem_package 'bundler' do
    options '--no-ri --no-rdoc'
  end

  # bundle install
  execute 'bundle install' do
    cwd params[:path]
    command "/usr/local/bin/bundle install --path /home/#{params[:user]}/.bundler"
    user params[:user]
    group params[:group]
    only_if { File.directory?(params[:path]) }
  end
end