FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PRINC := "${@int(PRINC) + 1}"

SRC_URI += " \
    file://musb-port0-host.patch \
    file://i2c1-enable.patch \
 "


