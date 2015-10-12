if platform? 'ubuntu'
  # lsb service
  sonarr_init_service 'sonarr' do
    style 'lsb'
  end

  # upstart service
  sonarr_init_service 'sonarr' do
    style 'upstart'
  end
end

if platform? 'debian'
  sonarr_init_service 'sonarr' do
    style 'systemd'
  end
end
