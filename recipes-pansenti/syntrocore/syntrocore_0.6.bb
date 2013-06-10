SUMMARY = "Core libraries and applications for Syntro"
HOMEPAGE = "http://www.pansenti.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit qt4e

DEPENDS += "pkgconfig"

PR = "6"

SRC_URI = "ftp://www.pansenti.com/syntro/SyntroCore-${PV}.tar.bz2"
SRC_URI[md5sum] = "86cdb508aaebc28f2c5496113286b31e"
SRC_URI[sha256sum] = "4e73063b1c22371ec596eeec6c7faaea4cf4c818d8470a94461cd05857ce0c09"

S = "${WORKDIR}"

do_install() {
    export INSTALL_ROOT=${D}
    make install

    install -d ${D}${libdir}/pkgconfig/
    install -m 0644 ${S}/SyntroLib/syntro.pc ${D}${libdir}/pkgconfig/
}

FILES_${PN} = "${libdir} ${bindir}"

