SUMMARY = "Syntro V4L camera application"
HOMEPAGE = "http://www.pansenti.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit qt4e pkgconfig

DEPENDS += "syntrocore"

PR = "1"

SRC_URI = "ftp://www.pansenti.com/syntro/SyntroV4LCamera-${PV}.tar.bz2"
SRC_URI[md5sum] = "9091d48d33c6d3c80d18f29e6c995f52"
SRC_URI[sha256sum] = "594557782477e1d3f667f12253d066a52c40b4c4842adffe279fea4edec3dbf8"

S = "${WORKDIR}"

do_install() {
	export INSTALL_ROOT=${D}
	make install
}

FILES_${PN} = "${bindir}"

