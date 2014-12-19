require 'spec_helper'

describe package('newrelic_plugin') do
  it { should be_installed.by('gem').with_version('1.3.1') }
end

describe user('root') do
  it { should exist }
  it { should belong_to_group 'root' }
end

describe command('sudo /etc/init.d/newrelic-example-plugin status') do
  its(:stdout) { should match /running/ }
end