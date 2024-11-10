# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3 eutils

DESCRIPTION="INDI driver for the Cam86 CCD"
HOMEPAGE="https://github.com/gehelem/indi_cam86_ccd"
EGIT_REPO_URI="https://github.com/gehelem/indi_cam86_ccd.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}"

LICENSE="GPL-3"
KEYWORDS="~amd64"

SLOT="0/1"

DEPEND="sci-libs/indilib dev-embedded/libftdi"

RDEPEND="${DEPEND}"

#INDI_GIT_DIR="${PN%%lib-driver-*}${PN##*-driver}"

#S="${EGIT_CHECKOUT_DIR}/${INDI_GIT_DIR}"
