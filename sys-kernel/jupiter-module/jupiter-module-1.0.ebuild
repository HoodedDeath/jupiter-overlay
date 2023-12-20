EAPI=8
DESCRIPTION="Kernel module for the Jupiter (SteamDeck) platform"
HOMEPAGE="https://github.com/firlin123/jupiter-dkms"
SRC_URI="https://github.com/firlin123/${PN%%module}dkms/archive/refs/heads/main.zip"
S="${WORKDIR}/${PN%%module}dkms-main"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"

inherit linux-mod-r1

src_compile() {
	local modlist=( jupiter )
	local modargs=( KDIR="${KV_OUT_DIR}" KVER="${KV_FULL}" )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	insinto /usr/lib/modules-load.d
	echo jupiter | newins - jupiter.conf
}
