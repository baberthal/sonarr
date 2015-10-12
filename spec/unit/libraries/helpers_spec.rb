require 'spec_helper'
require './libraries/helpers'

class DummyInclude; include SonarrCookbook::Helpers; end

module SonarrCookbook
  RSpec.describe Helpers do
    subject { DummyInclude.new }

    describe '#mono_repo_distribution' do
      shared_examples 'distribution' do |repo, distro|
        it "returns #{distro} when given #{repo}" do
          expect(subject.mono_repo_distribution(repo)).to eq distro
        end
      end
      include_examples 'distribution', 'mono-xamarin', 'wheezy'
      include_examples 'distribution', 'base', 'wheezy'
      include_examples 'distribution', 'mod_mono', 'wheezy-apache24-compat'
      include_examples 'distribution', 'libgdiplus', 'wheezy-libjpeg62-compat'
      include_examples 'distribution', 'libtiff', 'wheezy-libtiff-compat'
    end

    describe '#mono_repo_fullname' do
      shared_examples 'fullname' do |repo, name|
        it "returns #{name} when passed #{repo}" do
          expect(subject.mono_repo_fullname(repo)).to eq name
        end
      end
      include_examples 'fullname', 'base', 'mono-xamarin'
      include_examples 'fullname', 'mono-xamarin', 'mono-xamarin'
      include_examples 'fullname', 'mod_mono', 'mono-mod_mono'
      include_examples 'fullname', 'libgdiplus', 'mono-libgdiplus'
      include_examples 'fullname', 'libtiff', 'mono-libtiff'
    end

    describe '#group_for_daemon_user' do
      it 'returns root when passed root' do
        expect(subject.group_for_daemon_user('root')).to eq 'root'
      end

      it 'returns nothing when passed something else' do
        expect(subject.group_for_daemon_user('whatever')).to eq 'nogroup'
      end
    end
  end
end
