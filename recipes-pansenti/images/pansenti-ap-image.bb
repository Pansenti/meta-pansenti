SUMMARY = "A development image with WIFI Access Point support (duovero)"
HOMEPAGE = "http://www.pansenti.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

require pansenti-console-image.bb

PR = "0"

AP_SUPPORT = " \
    bridge-utils \
    dhcp-server \
    dhcp-server-config \
    hostap-daemon \
    iptables \
 "

IMAGE_INSTALL += " \
    ${AP_SUPPORT} \
 "

export IMAGE_BASENAME = "pansenti-ap-image"

