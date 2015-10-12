require 'spec_helper'

RSpec.describe 'sonarr::mono' do
  let(:chef_run) { ChefSpec::SoloRunner.new(opts).converge(described_recipe) }
  shared_examples 'converges successfully' do
    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on an unspecified platform' do
    let(:opts) { {} }
    include_examples 'converges successfully'
    it 'installs the mono packages' do
      expect(chef_run).to install_package('mono-complete')
      expect(chef_run).to install_package('mono-devel')
    end
  end

  supported_deb_distros = {
    'debian' => %w(8.0),
    'ubuntu' => %w(12.04 13.10 14.04)
  }

  supported_deb_distros.each do |distro, versions|
    versions.each do |version|
      context "When all attributes are default, on #{distro} v#{version}" do
        let(:opts) { { platform: distro, version: version } }
        include_examples 'converges successfully'

        it 'includes the recipe sonarr::mono_deb' do
          expect(chef_run).to include_recipe 'sonarr::mono_deb'
        end

        it 'installs the mono packages' do
          expect(chef_run).to install_package('mono-complete')
          expect(chef_run).to install_package('mono-devel')
        end
      end
    end
  end
end
