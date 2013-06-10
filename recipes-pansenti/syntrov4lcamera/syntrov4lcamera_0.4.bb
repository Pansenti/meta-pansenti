SUMMARY = "Syntro V4L camera application"
HOMEPAGE = "http://www.pansenti.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit qt4e pkgconfig

DEPENDS += "syntrocore"

PR = "0"

SRC_URI = "ftp://www.pansenti.com/syntro/SyntroV4LCamera-${PV}.tar.bz2"
SRC_URI[md5sum] = "21e8573ca099c0178eab546070411aa3"
SRC_URI[sha256sum] = "a5dbace37b8119f6524d19c8bb2a8c10cb532df7b0ff9e3a628574c99ec24f8c"

S = "${WORKDIR}"

do_install() {
	export INSTALL_ROOT=${D}
	make install
}

FILES_${PN} = "${bindir}"

