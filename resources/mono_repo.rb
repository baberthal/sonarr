property :repo_name, String, name_property: true
property :uri, String, default: 'http://download.mono-project.com/repo/debian'
property :components, Array, default: %w(main)
property :keyserver, String, default: 'hkp://keyserver.ubuntu.com:80'
property :key, String, default: '3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF'

include SonarrCookbook::Helpers

action :add do
  if platform_family? 'debian'
    apt_repository mono_repo_fullname(new_resource.name) do
      uri 'http://download.mono-project.com/repo/debian'
      distribution mono_repo_distribution(new_resource.name)
      components %w(main)
      keyserver 'hkp://keyserver.ubuntu.com:80'
      key '3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF'
    end
  end
end
