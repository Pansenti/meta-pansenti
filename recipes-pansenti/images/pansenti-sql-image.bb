SUMMARY = "A development image with postgresql server and development files"
HOMEPAGE = "http://www.pansenti.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

require pansenti-gst-image.bb

PR = "0"

POSTGRESQL_PACKAGES = " \
    postgresql \
    postgresql-client \
    postgresql-dev \
 "

IMAGE_INSTALL += " \
    ${POSTGRESQL_PACKAGES} \
 "

export IMAGE_BASENAME = "pansenti-sql-image"

