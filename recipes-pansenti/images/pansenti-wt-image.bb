SUMMARY = "A development image with Wt binaries and development files"
HOMEPAGE = "http://www.pansenti.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

require pansenti-qte-image.bb

PR = "0"

WT_BUILD_TOOLS = " \
    boost-dev \
    cmake \
    wt \
    wt-dev \
 "

IMAGE_INSTALL += " \
    ${WT_BUILD_TOOLS} \
 "

export IMAGE_BASENAME = "pansenti-wt-image"

