# Sonarr

## Overview
This cookbook installs and configures Sonarr. Currently, only ubuntu is fully
supported, but support for CentOS, RHEL and Debian are coming soon.

## Attributes
The following section details the attributes applied by this cookbook.

### Default
`sonarr['install_method']` - The method to use to install sonarr/nzbget.
Defaults to `package`. Can also be `source`.

`sonarr['install_dir']` - The directory where the sonarr installation will live.
Defaults to `/opt/NzbDrone`. Only respected if `sonarr['install_method']` is set
to `source`, as all sonarr/nzbdrone packages are installed to `/opt/NzbDrone`.

### Mono
As Sonarr is written in C#, it requires mono to run on a linux system. These
attributes define how and where mono will be installed on your system.

`sonarr['mono']['install_method']` - The method used to install mono. Defaults
to `package`. Can also be `source`. Please note that `package` is significantly
easier than `source` and is the recommended method.

`sonarr['mono']['path']` - The path to the installed executable. Defaults to
`/usr/bin/mono` if `sonarr['mono']['install_method']` is set to `package`,
otherwise it defaults to `/usr/local/bin/mono`. Please do not set this attribute
if you are installing from a package, as the service scripts need to know the
absolute location of the mono executable to run properly.

`sonarr['mono']['version']` - Set this if you wish to pin the version of mono
installed on your system. Defaults to the latest stable release.

`sonarr['mono']['packages']` - Which packages you wish to install from the mono
repositories. Only respected if `sonarr['mono']['install_method']` is set to
`package`, otherwise the entire source will be built.

`sonarr['mono']['release_channel']` - The release channel of mono packages to
subscribe to. Defaults to `stable`. Valid values are `stable`, `alpha`, and
`beta`.

## Recipes
### Default
Installs mono, adds the sonarr apt repository, and installs the package to your
system. Includes the `mono` recipe by default.

### Mono
Installs and configures mono. This recipe is intended to be used as a part of
the entire cookbook, but it should function properly on its own. Provides an
lwrp if the user wishes to configure additional mono repositories.

## LWRPs
### sonarr_mono_repo
#### Properties
`repo_name` - The name of the repository to add.

`uri` - The uri of the repository being added. Defaults to
`http://download.mono-project.com/repo/$DISTRO`. Should not need to be changed.

`components` - Which repository components to include. Defaults to `main` and
should not need to be changed.

`keyserver` - The keyserver to use for the apt repository. Defaults to
`hkp://keyserver.ubuntu.com` for Ubuntu systems.

`key` - The key to use to verify the package downloads. Defaults to
`3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF`, the key published on the mono
project website.

#### Actions
`add` - Add a mono repository.

## Usage
Include the recipe in your node's run list:
```json
run_list: [
    "recipe[sonarr]"
    ...
]
```

Or include it in your cookbook:
```ruby
include_recipe 'sonarr'
```

## Contributing
1. Fork this repository.
2. Create a branch for your feature.
3. Write tests for your feature. This is important! We are responsible
   developers.
4. Submit a pull request.
5. ???
6. Profit
