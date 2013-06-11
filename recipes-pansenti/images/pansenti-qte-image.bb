SUMMARY = "A development image with Qt embedded and some Syntro apps"
HOMEPAGE = "http://www.pansenti.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

require pansenti-console-image.bb

PR = "1"

QT_TOOLS = " \
    qt4-embedded-dev\
    qt4-embedded \
 "

PSPLASH = "psplash"

PSPLASH_overo = ""

SYNTRO = " \
    camera-start \
    syntrocore \
    syntrocore-dev \
    syntrocam \
 "

IMAGE_INSTALL += " \
    ${QT_TOOLS} \
    ${PSPLASH} \
    ${SYNTRO} \
 "

export IMAGE_BASENAME = "pansenti-qte-image"

