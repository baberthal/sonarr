require 'spec_helper'
require_relative 'shared_examples'

RSpec.describe 'sonarr::mono_deb' do
  let(:chef_run) { ChefSpec::SoloRunner.new(opts).converge(described_recipe) }
  context 'When all attributes are default, on a debian 8.0 platform' do
    let(:opts) { { platform: 'debian', version: '8.0' } }
    include_examples 'converges successfully'
    describe 'added repositories' do
      include_examples 'adds the base repository'
      include_examples 'mod_mono repository'
      it 'adds the libgdiplus repository' do
        expect(chef_run).to add_mono_repo('libgdiplus').with(
          uri: 'http://download.mono-project.com/repo/debian',
          components: %w(main),
          keyserver: 'hkp://keyserver.ubuntu.com:80',
          key: '3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF'
        )
      end
    end
  end

  context 'when all attributes are default, on an ubuntu platform' do
    context 'when the platform requires libtiff' do
      versions = %w(12.04)
      versions.each do |version|
        context "on Ubuntu v#{version}" do
          let(:opts) { { platform: 'ubuntu', version: version } }
          include_examples 'converges successfully'
          include_examples 'libtiff repository'
        end
      end
    end

    context 'when the platform does not require libtiff' do
      versions = %w(13.10 14.04 14.10)
      versions.each do |version|
        context "on Ubuntu v#{version}" do
          let(:opts) { { platform: 'ubuntu', version: version } }
          include_examples 'converges successfully'
          include_examples 'mod_mono repository'
        end
      end
    end
  end
end
