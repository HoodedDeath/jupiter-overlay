EAPI=8
DESCRIPTION="Background service for adding fan control for the Jupiter (SteamDeck) Platform"
HOMEPAGE="https://github.com/firlin123/jupiter-fan-control"
SRC_URI="https://github.com/firlin123/jupiter-fan-control/archive/refs/tags/20230209.1.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="openrc systemd autoenable-service"
REQUIRED_USE="openrc? ( !systemd ) systemd? ( !openrc ) autoenable-service? ( ^^ ( openrc systemd ) )"
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
  if use autoenable-service ; then
    if use openrc ; then rc-update add jupiter-fan-control default; fi
    if use systemd ; then systemctl enable jupiter-fan-control.service; fi
  fi
}

pkg_prerm() {
  if use openrc ; then rc-update del jupiter-fan-control default; fi
  if use systemd ; then systemctl disable jupiter-fan-control.service; fi
}
