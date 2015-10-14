#
# Cookbook Name:: sonarr
# Recipe:: mono
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
#
include_recipe 'apt'

# Main mono repository
sonarr_mono_repo 'base'

# Additional mono repositories, depending on distro and version
additional_repos = value_for_platform(
  'debian' => {
    '>= 7.6' => %w(mod_mono libgdiplus)
  },
  'ubuntu' => {
    '>= 13.04' => %w(mod_mono),
    '12.10' => %w(libtiff),
    '12.04' => %w(libtiff)
  }
)

additional_repos.each do |mono_repository|
  sonarr_mono_repo mono_repository
end

node['sonarr']['mono']['packages'].each do |pkg|
  package pkg
end
