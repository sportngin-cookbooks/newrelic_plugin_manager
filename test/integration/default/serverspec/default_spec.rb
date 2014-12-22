require 'spec_helper'

describe package('newrelic_plugin') do
  it { should be_installed.by('gem').with_version('1.3.1') }
end

describe user('deploy') do
  it { should exist }
  it { should belong_to_group 'deploy' }
end

describe command('sudo /etc/init.d/newrelic-example-plugin status') do
  its(:stdout) { should match /running/ }
end

describe command('sudo /etc/init.d/newrelic-wikipedia-java-plugin status') do
  its(:stdout) { should match /running/ }
end