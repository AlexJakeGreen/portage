# Copyright 1999-2020
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="New libpurple plugin for Telegram"
HOMEPAGE="https://github.com/dazboga/tdlib-purple"
# EGIT_REPO_URI="https://github.com/dazboga/${PN}.git"
EGIT_REPO_URI="https://github.com/ars3niy/${PN}.git"

#LICENSE="*"
SLOT=0
KEYWORDS="~amd64 ~x86"

IUSE="webp lottie system-lottie voip"

REQUIRED_USE="system-lottie? ( lottie )"

BDEPEND="
	virtual/pkgconfig
"

RDEPEND="
	net-im/pidgin
	net-libs/tdlib
	voip? (
		media-libs/libtgvoip
	)
	webp? (
		media-libs/libpng
		media-libs/libwebp
	)
	system-lottie? (
		media-libs/rlottie
	)
"

DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-CMakeLists.patch
	"${FILESDIR}"/${P}-tdlib-1.8.patch
)


src_configure() {
    # general configuration
   local mycmakeargs=(
    -DNoVoip=$(usex !voip)
	-DNoWebp=$(usex !webp)
	-DNoLottie=$(usex !lottie)
	-DNoBundledLottie=$(usex system-lottie)
   )
   cmake_src_configure
}
