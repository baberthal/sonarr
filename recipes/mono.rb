#
# Cookbook Name:: sonarr
# Recipe:: mono
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
include_recipe 'sonarr::mono_deb' if platform_family? 'debian'
include_recipe 'sonarr::mono_rhel' if platform_family? 'rhel'

packages = node['sonarr']['mono']['packages']

packages.each do |pkg|
  package pkg
end
