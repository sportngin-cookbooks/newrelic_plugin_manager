define :bundle_install do
  gem_package 'io-console' # Undeclared dependency of Bundler  1.9.1+
  gem_package 'bundler'

  # bundle install
  execute 'bundle install' do
    cwd params[:path]
    command "bundle install --path #{params[:path]}/.vendor/bundle"
    environment 'PATH' => "/usr/local/bin:/usr/bin:#{ENV['PATH']}"
    user params[:user]
    group params[:group]
    only_if { File.directory?(params[:path]) }
  end
end
