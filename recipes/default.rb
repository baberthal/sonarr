#
# Cookbook Name:: sonarr
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
include_recipe 'sonarr::mono'

apt_repository 'sonarr' do
  uri 'http://apt.sonarr.tv'
  distribution 'master'
  components %w(main)
  keyserver 'keyserver.ubuntu.com'
  key 'FDA5DFFC'
end

apt_package 'nzbdrone'
