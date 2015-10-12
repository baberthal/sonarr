#
# Cookbook Name:: sonarr
# Recipe:: _deb
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
apt_repository 'sonarr' do
  uri 'http://apt.sonarr.tv'
  distribution 'master'
  components %w(main)
  keyserver 'keyserver.ubuntu.com'
  key 'FDA5DFFC'
end

apt_package 'nzbdrone'

sonarr_init_service 'sonarr' do
  style node['sonarr']['service']['init_style']
end
