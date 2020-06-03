define :bundle_install do
  gem_package 'io-console' do
    version '~> 0.4.0'
  end

  gem_package 'bundler' do
    version '1.17.3'
    not_if 'gem which bundler'
  end

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
