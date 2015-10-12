#
# Cookbook Name:: sonarr
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
include_recipe 'sonarr::mono'

group node['sonarr']['service']['group'] do
  action :create
end

directory "/opt/#{node['sonarr']['service']['user']}" do
  recursive true
end

user node['sonarr']['service']['user'] do
  action :create
  gid node['sonarr']['service']['group']
  home "/opt/#{node['sonarr']['service']['user']}"
  shell '/bin/bash'
end

directory "/opt/#{node['sonarr']['service']['user']}" do
  owner node['sonarr']['service']['user']
end

include_recipe 'sonarr::_deb' if platform_family? 'debian'
include_recipe 'sonarr::_rhel' if platform_family? 'rhel'
