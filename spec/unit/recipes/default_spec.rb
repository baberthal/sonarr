#
# Cookbook Name:: sonarr
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'
require_relative 'shared_examples'

RSpec.describe 'sonarr::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(opts).converge(described_recipe) }

  supported_platforms = {
    'ubuntu' => %w(12.04 14.04),
    'debian' => %w(8.0)
  }

  supported_platforms.each do |platform, versions|
    versions.each do |version|
      context "On #{platform} #{version}" do
        let(:opts) { { platform: platform, version: version } }
        include_examples 'converges successfully'
        it 'includs the _deb recipe' do
          expect(chef_run).to include_recipe 'sonarr::_deb'
        end
      end
    end
  end
end
