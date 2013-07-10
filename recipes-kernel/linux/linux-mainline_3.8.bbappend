FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PRINC := "${@int(PRINC) + 2}"

SRC_URI += " \
    file://i2c1-enable.patch \
    file://musb-port0-host.patch \
 "

