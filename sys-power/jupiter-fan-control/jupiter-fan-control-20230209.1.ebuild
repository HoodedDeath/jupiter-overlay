EAPI=8
DESCRIPTION="Background service for adding fan control for the Jupiter (SteamDeck) Platform"
HOMEPAGE="https://github.com/firlin123/jupiter-fan-control"
SRC_URI="https://github.com/firlin123/${PN}/archive/refs/tags/${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="openrc systemd"
REQUIRED_USE="openrc? ( !systemd ) systemd? ( !openrc )"
RDEPEND="openrc? ( sys-apps/openrc ) systemd? ( sys-apps/systemd ) >=dev-python/pyyaml-6.0.1-r1 >=dev-lang/python-3.12.0_p1"
DEPEND="${RDEPEND}"

src_compile() {
  return 0
}

src_install() {
  insinto /usr/share/jupiter-fan-control
  insopts -m0755
  doins ${S}/usr/share/jupiter-fan-control/{{fancontrol,PID}.py,jupiter-fan-control-config.yaml}
  if use openrc ; then
    doinitd ${FILESDIR}/jupiter-fan-control
  fi
  if use systemd ; then
    insinto /usr/lib/systemd/system
    insopts -m0644
    doins ${S}/usr/lib/systemd/system/jupiter-fan-control.service
  fi
}

pkg_postinst() {
  use openrc && elog "The service has been installed as 'jupiter-fan-control' and should be started / added to default runlevel."
  use systemd && elog "The service has been installed as 'jupiter-fan-control.service' and should be started / enabled."
}

pkg_postrm() {
  use openrc && elog "The service 'jupiter-fan-control' has been uninstalled. If it was added to a runlevel, that link is now broken and should be removed."
  use systemd && elog "The service 'jupiter-fan-control.service' has been uninstalled. If it was enabled, that link is now broken and should be removed."
}
