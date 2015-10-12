require 'spec_helper'
def on_platform(platform, version)
  { platform: platform, version: version, step_into: ['sonarr_init_service'] }
end

RSpec.describe 'test::lwrp_init_service' do
  let(:chef_run) { ChefSpec::SoloRunner.new(opts).converge(described_recipe) }
  shared_examples 'starts and enables the init service' do
    subject { chef_run }
    it { is_expected.to start_service('sonarr') }
    it { is_expected.to enable_service('sonarr') }
  end

  context 'on debain platforms that use systemd' do
    let(:opts) { on_platform('debian', '8.0') }
    include_examples 'starts and enables the init service'
    describe 'the service template' do
      it 'creates the template' do
        expect(chef_run).to create_template(
          '/lib/systemd/system/sonarr.service').with(
            source: 'sonarr_systemd.service.erb',
            user: 'root',
            group: 'root',
            variables: {
              user: 'sonarr',
              group: 'sonarr',
              mono_path: '/usr/bin/mono',
              sonarr_exe: '/opt/NzbDrone/NzbDrone.exe'
            }
          )
      end
    end
  end

  context 'on ubuntu platforms' do
    %w(12.04 14.04).each do |version|
      context "on version #{version}" do
        let(:opts) { on_platform('ubuntu', version) }
        include_examples 'starts and enables the init service'
        describe 'lsb service' do
          it 'creates the template' do
            expect(chef_run).to create_template('/etc/init.d/sonarr').with(
              source: 'sonarr_lsb.erb',
              user: 'root',
              group: 'root',
              mode: 0755,
              variables: {
                daemon_path: '/opt/NzbDrone',
                user: 'sonarr'
              }
            )
          end
        end

        describe 'upstart service' do
          it 'creates the template' do
            expect(chef_run).to create_template('/etc/init/sonarr.conf').with(
              source: 'sonarr_upstart.conf.erb',
              user: 'root',
              group: 'root',
              mode: 0644,
              variables: {
                name: 'sonarr',
                daemon_path: '/opt/NzbDrone/NzbDrone.exe',
                user: 'sonarr',
                group: ''
              }
            )
          end
        end
      end
    end
  end
end
