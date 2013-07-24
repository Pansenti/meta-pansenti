DESCRIPTION = "Wt is a C++ library for developing web applications"
HOMEPAGE = "http://www.webtoolkit.eu/wt"
DEPENDS = "boost jpeg openssl sqlite3 zlib"

LICENSE = "GPL-2.0-with-OpenSSL-exception"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-with-OpenSSL-exception;md5=d9e4412f125e3e6f14efba8ce7b4604f"

inherit cmake

# this is what was tested
#SRCREV = "a7f27d80881e54d54d2a0bf2e11497c5be9a3966"
SRCREV = "${AUTOREV}"

SRC_URI = "git://github.com/kdeforche/wt.git \
           file://custom-cmakelists.patch \
          "
           
S = "${WORKDIR}/git"

EXTRA_OECMAKE = " \
                 -DCMAKE_INSTALL_PREFIX=${D}${prefix} \
                "

do_install() {
    export INSTALL_ROOT=${D}
    make install
}

FILES_${PN} = "${libdir} ${bindir} ${datadir} ${prefix}"

