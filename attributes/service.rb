default_service_init_style = value_for_platform(
  'debian' => {
    '>= 8.0' => 'systemd'
  },
  'ubuntu' => {
    '>= 15.0' => 'systemd',
    '< 15.0' => 'upstart'
  }
)

# Defaults to the values above. Valid choices are: systemd upstart lsb-init
default['sonarr']['service']['init_style'] = default_service_init_style
default['sonarr']['service']['systemd_dir'] = '/lib/systemd/system'
default['sonarr']['service']['user'] = 'sonarr'
default['sonarr']['service']['group'] = 'sonarr'
