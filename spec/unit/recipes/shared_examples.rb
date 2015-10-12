RSpec.shared_examples 'adds the base repository' do
  it 'adds the base repository' do
    expect(chef_run).to add_mono_repo('base').with(
      uri: 'http://download.mono-project.com/repo/debian',
      components: %w(main),
      keyserver: 'hkp://keyserver.ubuntu.com:80',
      key: '3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF'
    )
  end
end

RSpec.shared_examples 'mod_mono repository' do
  it 'adds the repository' do
    expect(chef_run).to add_mono_repo('mod_mono').with(
      uri: 'http://download.mono-project.com/repo/debian',
      components: %w(main),
      keyserver: 'hkp://keyserver.ubuntu.com:80',
      key: '3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF'
    )
  end
end

RSpec.shared_examples 'libtiff repository' do
  it 'adds the repository' do
    expect(chef_run).to add_mono_repo('libtiff').with(
      uri: 'http://download.mono-project.com/repo/debian',
      components: %w(main),
      keyserver: 'hkp://keyserver.ubuntu.com:80',
      key: '3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF'
    )
  end
end

RSpec.shared_examples 'converges successfully' do
  it 'does not raise an error' do
    expect { chef_run }.to_not raise_error
  end
end
