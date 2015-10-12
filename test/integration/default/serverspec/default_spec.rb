require 'spec_helper'

RSpec.describe 'sonarr::default' do
  context 'on debian systems', if: %w(debian ubuntu).include?(os[:family]) do
    describe 'installing mono' do
      describe 'mono apt repositories' do
        describe file('/etc/apt/sources.list.d') do
          it { is_expected.to be_directory }
          it { is_expected.to exist }
        end
        list_dir = '/etc/apt/sources.list.d'

        describe file("#{list_dir}/mono-xamarin.list") do
          it { is_expected.to exist }
          it { is_expected.to be_file }
          its(:content) { is_expected.to match(/wheezy main$/) }
        end

        if %w(14.04 8.0).include?(os[:release])
          describe file("#{list_dir}/mono-mod_mono.list") do
            it { is_expected.to exist }
            it { is_expected.to be_file }
            its(:content) { is_expected.to match(/wheezy-apache24-compat/) }
          end
        end

        if os[:family] == 'debian'
          describe file("#{list_dir}/mono-libgdiplus.list") do
            it { is_expected.to exist }
            it { is_expected.to be_file }
            its(:content) { is_expected.to match(/wheezy-libjpeg62-compat/) }
          end
        end

        if os[:release].start_with?('12')
          describe file("#{list_dir}/mono-libtiff.list") do
            it { is_expected.to exist }
            it { is_expected.to be_file }
            its(:content) { is_expected.to match(/wheezy-libtiff-compat/) }
          end
        end
      end

      describe package('mono-complete') do
        it { is_expected.to be_installed }
      end

      describe package('mono-devel') do
        it { is_expected.to be_installed }
      end
    end

    describe file('/etc/apt/sources.list.d/sonarr.list') do
      it { is_expected.to exist }
      it { is_expected.to be_file }
      its(:content) { is_expected.to match(/master main$/) }
    end

    describe package('nzbdrone') do
      it { is_expected.to be_installed }
    end

    context 'on debian 8.0 with systemd', if: os[:family] == 'debian' do
      describe file('/lib/systemd/system/sonarr.service') do
        it { is_expected.to exist }
        it { is_expected.to be_file }
        it { is_expected.to be_executable }
        its(:content) { is_expected.to match(/Type=simple/) }
      end
    end

    context 'on ubuntu systems with upstart', if: os[:family] == 'ubuntu' do
      describe file('/etc/init/sonarr.conf') do
        it { is_expected.to exist }
        it { is_expected.to be_file }
        its(:content) { is_expected.to match(/setuid sonarr/) }
      end
    end

    describe service('sonarr') do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end
  end
end
