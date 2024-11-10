# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit gnome.org gnome2-utils meson xdg

DESCRIPTION="Books is an e-book manager application for GNOME."
HOMEPAGE="https://wiki.gnome.org/Apps/Books"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="
	>=gnome-base/gnome-${PV}
	>=gnome-extra/gnome-documents-3.33.90
	>=app-text/libgepub-0.6.0
"

DEPEND="${RDEPEND}"

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
