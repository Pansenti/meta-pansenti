DESCRIPTION = "Wt is a C++ library for developing web applications"
HOMEPAGE = "http://www.webtoolkit.eu/wt"
DEPENDS = "boost openssl sqlite3 zlib"

LICENSE = "GPL-2.0-with-OpenSSL-exception"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-with-OpenSSL-exception;md5=d9e4412f125e3e6f14efba8ce7b4604f"

inherit cmake

PR = "3"

SRCREV = "${AUTOREV}"
SRC_URI = "git://github.com/kdeforche/wt.git \
           file://custom-cmakelists.patch \
           file://default-log-level.patch \
          "
           
S = "${WORKDIR}/git"

EXTRA_OECMAKE = "-DCMAKE_INSTALL_PREFIX=${D}${prefix}"

do_install() {
    export INSTALL_ROOT=${D}
    make install

    install -d ${D}${sysconfdir}/wt/
    install -m 0644 ${S}/wt_config.xml ${D}${sysconfdir}/wt/
}

FILES_${PN} = "${libdir} ${bindir} ${datadir} ${prefix} ${sysconfdir}"

