default['sonarr']['mono'] = {
  'install_method' => 'package',
  'path' => '/usr/bin/mono',
  'version' => '3.x',
  'packages' => %w(mono-devel mono-complete),
  'release_channel' => 'stable' # can be stable | alpha | beta
}
