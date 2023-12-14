EAPI=8
DESCRIPTION="DKMS module for the Jupiter (SteamDeck) platform"
HOMEPAGE="https://github.com/firlin123/jupiter-dkms"
SRC_URI="https://github.com/firlin123/jupiter-dkms/archive/refs/heads/main.zip"
S="${WORKDIR}/jupiter-dkms-main"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="autobuild-dkms"
RDEPEND="sys-kernel/dkms"
DEPEND="${RDEPEND}"

src_compile() {
	return 0
}

src_install() {
	insinto /usr/src/jupiter-1.0
	insopts -m0644
	doins ${S}/{Makefile,jupiter.c} ${FILESDIR}/dkms.conf
	dodir /usr/lib/modules-load.d
	insinto /usr/lib/modules-load.d
	echo jupiter | newins - jupiter.conf
}

pkg_postinst() {
	if use autobuild-dkms ; then
		kvers=($(ls ${ROOT}/lib/modules))
	  for k in ${kvers[@]}; do
		  dkms install -q -k ${k} jupiter/1.0
	  done
	  elog "Jupiter DKMS module was installed for the following kernels:"
	  elog "	[ ${kvers[@]} ]"
	else
	  elog "With USE=-autobuild-dkms, you'll need to build the modules yourself"
	fi
}

pkg_prerm() {
  if use autobuild-dkms ; then
    kvers=($(ls ${ROOT}/lib/modules))
	  for k in ${kvers[@]}; do
		  dkms uninstall -k ${k} jupiter/1.0
	  done
	  elog "Jupiter DKMS module was uninstalled for the following kernels:"
	  elog "	[ ${kvers[@]} ]"
	else
	  elog "With USE=-autobuild-dkms, you'll need to remove modules yourself"
	fi
}
