# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="kbdd plugin for wayfire"
HOMEPAGE="https://github.com/AlexJakeGreen/wayfire-kbdd-plugin"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AlexJakeGreen/wayfire-kbdd-plugin.git"
else
        SRC_URI="https://github.com/AlexJakeGreen/wayfire-kbdd-plugin/archive/refs/tags/${PV}.tar.gz"
	KEYWORDS="amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	gui-libs/wlroots:=
	>=gui-wm/wayfire-0.7.0
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"
