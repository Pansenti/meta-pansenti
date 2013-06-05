SUMMARY = "Syntro V4L camera application"
HOMEPAGE = "http://www.pansenti.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit qt4e pkgconfig

DEPENDS += "syntrocore"

PR = "1"

SRC_URI = "ftp://www.pansenti.com/syntro/SyntroV4LCamera-${PV}.tar.bz2"
SRC_URI[md5sum] = "1d9afc6b2b666865ae3ee174eef0d71e"
SRC_URI[sha256sum] = "ce8dfdc299c61041e04eb297161e2b122bdfb7cd316f347e32142f0b81677673"

S = "${WORKDIR}"

do_install() {
	export INSTALL_ROOT=${D}
	make install
}

FILES_${PN} = "${bindir}"

