# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

MY_PN="OpenGothic"

if [[ "${PV}" == 9999 ]]; then
    inherit git-r3

    EGIT_REPO_URI="https://github.com/Try/${MY_PN}.git"
    EGIT_SUBMODULES=(
	lib/ZenLib
	lib/Tempest
	lib/bullet3
	lib/TinySoundFont
    )
else
    OPENGOTHIC_COMMIT_SHA="c9c807936e95292b47e1667964be2243439d25c3" # 0.52
    Tempest="16a9f590294657c4ea75b8fd8c924d31227114f6"
    TinySoundFont="d4ffcdc8a34d3f61f22e4b283b4c100f5adf4b82"
    ZenLib="8ac4d2c385fe2fabfe8aa060f5bfbb69cbf922ea"
    bullet3="e7e46154bb2f4be77ad79657bcdc2675305b69a4"
    libsquish="f5e44a360fd8b456b1291a2eaba61871c64d6288"
    SRC_URI="
    https://github.com/Try/${MY_PN}/archive/${OPENGOTHIC_COMMIT_SHA}.tar.gz -> ${P}.tar.gz
    https://github.com/Try/Tempest/archive/${Tempest}.tar.gz -> ${P}-lib_Tempest.tar.gz
    https://github.com/schellingb/TinySoundFont/archive/${TinySoundFont}.tar.gz -> ${P}-lib_TinySoundFont.tar.gz
    https://github.com/Try/ZenLib/archive/${ZenLib}.tar.gz -> ${P}-lib_ZenLib.tar.gz
    https://github.com/bulletphysics/bullet3/archive/${bullet3}.tar.gz -> ${P}-lib_bullet3.tar.gz
    https://github.com/tito/libsquish/archive/${libsquish}.tar.gz -> ${P}-lib_ZenLib_lib_libsquish.tar.gz
  "
    S="${WORKDIR}/${MY_PN}-${OPENGOTHIC_COMMIT_SHA}"
fi

DESCRIPTION="Reimplementation of Gothic 2 Notr"
HOMEPAGE="https://github.com/Try/OpenGothic"
LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""

DEPEND="
    media-libs/mesa[vulkan]
    dev-util/glslang
    dev-util/vulkan-headers
    media-libs/vulkan-loader
    dev-util/cmake
"
RDEPEND="${DEPEND}"

src_unpack() {
    if [[ "${PV}" == "9999" ]]; then
	git-r3_src_unpack
    else
	unpack "${P}.tar.gz"

	cd "${S}" || die
	local i list=(
	    lib_Tempest
	    lib_TinySoundFont
	    lib_ZenLib
	    lib_bullet3
	    lib_ZenLib_lib_libsquish
	)


	for i in "${list[@]}"; do
	    tar xf "${DISTDIR}/${P}-${i}.tar.gz" --strip-components 1 -C "${i//_//}" || die "Failed to unpack ${P}-${i}.tar.gz"
	done

    fi
}

src_configure() {
    local mycmakeargs=(
	-DBUILD_SHARED_LIBS=OFF
	-DOpenGL_GL_PREFERENCE=GLVND
	-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo
    )

    cmake_src_configure
}

src_compile() {
    cmake_src_compile
}

src_install() {
    cmake_src_install

    # Do not violate multilib strict
    mv "${ED}/usr/lib/libTempest.so" "${ED}/usr/$(get_libdir)" || die "mv failed"
}
