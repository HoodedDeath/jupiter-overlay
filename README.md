# jupiter-overlay

## Description
A simple repo to add Jupiter kernel module and fan control packages to a Gentoo installation

Currently contains two packages: `sys-kernel/jupiter-dkms` providing the DKMS module for the Jupiter ACPI platform drivers, and `sys-power/jupiter-fan-control` providing a service (OpenRC or SystemD) to control the fan.

## Adding to Gentoo
Copy `jupiter-overlay.conf` to `/etc/portage/repos.conf/` and sync.

## Jupiter DKMS
Available USE: `autobuild-dkms`

Default USE: None

With `autobuild-dkms` USE enabled, the package will attempt to automatically install module for all kernels found in `/lib/modules` when merging, and uninstall module for all kernels found when unmerging.

## Jupiter Fan Control
Available USE: `openrc systemd autoenable-service`

Default USE: None

With `openrc` USE enabled, the package will install a provided OpenRC service file to run the fan control program.

With `systemd` USE enabled, the package will install a provided SystemD service file to run the fan control program.

With `autoenable-service` USE enabled, the package will enable whichever service corresponds to the chosen above USE (runlevel `default` for OpenRC, target `multi-user` for SystemD).

Note: `openrc` and `systemd` USE are exclusive. Only one may be enabled at a time.

Note: `autoenable-service` USE requires one of `openrc` or `systemd` USE.

## Adding to Gentoo
Copy `jupiter-overlay.conf` from this repo to `/etc/portage/repos.conf/`

## Credits
DKMS source and fan control program pulled from [firlin123/jupiter-dkms](https://github.com/firlin123/jupiter-dkms) and [firlin123/jupiter-fan-control](https://github.com/firlin123/jupiter-fan-control) respectively. Ebuilds were adapted from firlin123's AUR PKGBUILD files and have version numbers matching said PKGBUILD.
