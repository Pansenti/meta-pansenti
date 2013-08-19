SUMMARY = "A development image with Wt binaries and development files"
HOMEPAGE = "http://www.pansenti.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

require pansenti-wt-image.bb

PR = "0"

GSTREAMER_PACKAGES = " \
    gst-fsl-plugin \
    gst-fsl-plugin-gplay \
    gst-meta-audio \
    gst-meta-video \
    gst-plugins-good-meta \
    gpu-viv-bin-mx6q \
    gpu-viv-bin-mx6q-dev \
    gst-plugins-base-videotestsrc \    
 "

# install vpu firmware for both dual and quad boards on all images
VPU_FIRMWARE = " \
    firmware-imx-vpu-imx6d \
    firmware-imx-vpu-imx6q \
 "

IMAGE_INSTALL += " \
    ${GSTREAMER_PACKAGES} \
    ${VPU_FIRMWARE} \
    v4l-utils \
 "

export IMAGE_BASENAME = "pansenti-gst-image"

