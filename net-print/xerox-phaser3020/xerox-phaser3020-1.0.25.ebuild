# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="XEROX Phaser 3020 drivers for CUPS"
HOMEPAGE="https://www.support.xerox.com/en-us/product/phaser-3020/downloads?platform=linux&category=drivers&language=en"

SRC_URI="https://download.support.xerox.com/pub/drivers/3020/drivers/linux/en_GB/Xerox_Phaser_3020_Linux-Driver.tar.gz"
LICENSE="Xerox"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="net-print/cups"

S="${WORKDIR}/${MY_PN}/uld"

src_install() {
	#insinto /usr/share/cups/model
	#doins noarch/share/ppd/*.ppd || die "missing ppd files"
    bash install-printer.sh
}
