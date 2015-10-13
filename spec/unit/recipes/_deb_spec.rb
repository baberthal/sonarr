#
# Cookbook Name:: sonarr
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'
require_relative 'shared_examples'

RSpec.describe 'sonarr::_deb' do
  let(:chef_run) { ChefSpec::SoloRunner.new(opts).converge(described_recipe) }
  shared_examples 'adds the sonarr repo and pkg' do
    it 'adds the sonarr apt repo' do
      expect(chef_run).to add_apt_repository('sonarr').with(
        uri: 'http://apt.sonarr.tv',
        distribution: 'master',
        components: %w(main),
        keyserver: 'keyserver.ubuntu.com',
        key: 'FDA5DFFC'
      )
    end

    it 'installs the sonarr package' do
      expect(chef_run).to install_apt_package('nzbdrone')
    end
  end

  context 'When all attributes are default, on a debian 8.0 platform' do
    let(:opts) { { platform: 'debian', version: '8.0' } }
    include_examples 'converges successfully'
    include_examples 'adds the sonarr repo and pkg'
  end

  %w(12.04 14.04).each do |version|
    context "When all attributes are default, on Ubuntu #{version}" do
      let(:opts) { { platform: 'ubuntu', version: version } }
      include_examples 'converges successfully'
      include_examples 'adds the sonarr repo and pkg'
    end
  end
end
