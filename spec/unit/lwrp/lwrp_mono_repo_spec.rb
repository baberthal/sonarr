require 'spec_helper'
require_relative '../recipes/shared_examples'

RSpec.describe 'test::lwrp_mono_repo' do
  let(:chef_run) { ChefSpec::SoloRunner.new(opts).converge(described_recipe) }
  shared_examples 'base mono repo' do
    it 'creates the repo' do
      expect(chef_run).to add_apt_repository('mono-xamarin').with(
        uri: 'http://download.mono-project.com/repo/debian',
        distribution: 'wheezy',
        components: %w(main),
        keyserver: 'hkp://keyserver.ubuntu.com:80',
        key: '3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF'
      )
    end
  end

  supported_deb_distros = {
    'debian' => %w(8.0),
    'ubuntu' => %w(12.04 13.10 14.04)
  }

  supported_deb_distros.each do |dist, versions|
    versions.each do |v|
      context "When all attributes are default, on #{dist} v#{v}" do
        let(:opts) do
          { platform: dist, version: v, step_into: ['sonarr_mono_repo'] }
        end
        include_examples 'base mono repo'
      end
    end
  end
end
