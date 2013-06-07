SUMMARY = "Syntro V4L camera application"
HOMEPAGE = "http://www.pansenti.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit qt4e pkgconfig

DEPENDS += "syntrocore"

PR = "0"

SRC_URI = "ftp://www.pansenti.com/syntro/SyntroV4LCamera-${PV}.tar.bz2"
SRC_URI[md5sum] = "ed53aa0a8156e0fe189e205f7252b6a2"
SRC_URI[sha256sum] = "9d4f931020aefb0a364bb701d18dc87e0442fae7841924f11ca08dd675b09573"

S = "${WORKDIR}"

do_install() {
	export INSTALL_ROOT=${D}
	make install
}

FILES_${PN} = "${bindir}"

