SUMMARY = "Custom beaglebone board setup"

DESCRIPTION = "Initialize some pins and built in drivers for use with \
               a custom Pansenti development board."

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://board-setup.sh"

PR = "1"

S = "${WORKDIR}"

inherit update-rc.d

INITSCRIPT_NAME = "board-setup.sh"
INITSCRIPT_PARAMS = "start 90 5 ."

do_install_append () {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 board-setup.sh ${D}${sysconfdir}/init.d
}

FILES_${PN} = "${sysconfdir}"

