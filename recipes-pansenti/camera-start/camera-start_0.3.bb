SUMMARY = "Script to start SyntroCam at boot"

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://init.d/camera-start.sh \
           file://default/camera-start \
          "

PR = "0"

S = "${WORKDIR}"

inherit update-rc.d

INITSCRIPT_NAME = "camera-start.sh"
INITSCRIPT_PARAMS = "start 97 5 .  stop 3 0 6 ."

do_install_append () {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 init.d/camera-start.sh ${D}${sysconfdir}/init.d

    install -d ${D}${sysconfdir}/default
    install -m 0666 default/camera-start ${D}${sysconfdir}/default
}

FILES_${PN} = "${sysconfdir}"

