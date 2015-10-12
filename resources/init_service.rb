property :name, String, name_property: true
property :style, String, equal_to: %w(lsb upstart systemd)

include SonarrCookbook::Helpers

action :create do
  if style == 'lsb'
    template "/etc/init.d/#{name}" do
      source 'sonarr_lsb.erb'
      user 'root'
      group 'root'
      mode 0755
      variables(daemon_path: "#{node['sonarr']['install_dir']}/NzbDrone.exe",
                name: 'sonarr',
                group: group_for_daemon_user(node['sonarr']['service']['user']),
                user: node['sonarr']['service']['user'])
    end

  elsif style == 'upstart'
    template "/etc/init/#{name}.conf" do
      source 'sonarr_upstart.conf.erb'
      user 'root'
      group 'root'
      mode 0644
      variables(daemon_path: node['sonarr']['install_dir'],
                user: node['sonarr']['service']['user'])
    end

  elsif style == 'systemd'
    template "#{node['sonarr']['service']['systemd_dir']}/#{name}.service" do
      source 'sonarr_systemd.service.erb'
      user 'root'
      group 'root'
      mode 0777
      variables(user: node['sonarr']['service']['user'],
                group: node['sonarr']['service']['group'],
                mono_path: node['sonarr']['mono']['path'],
                sonarr_exe: "#{node['sonarr']['install_dir']}/NzbDrone.exe")
    end
  end

  service name do
    action [:start, :enable]
  end
end
