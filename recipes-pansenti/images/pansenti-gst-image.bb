SUMMARY = "A development image with Wt binaries and development files"
HOMEPAGE = "http://www.pansenti.com"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

require pansenti-wt-image.bb

PR = "0"

GSTREAMER_PACKAGES = " \
    gst-fsl-plugin \
    gst-fsl-plugin-gplay \
    gst-meta-base \
    gst-meta-audio \
    gst-meta-video \
    gst-meta-debug \
    gst-plugins-base-meta \
    gst-plugins-base-dev \
    gst-plugins-good-meta \
    gst-plugins-good-dev \
    gst-plugins-bad-meta \
    gst-plugins-bad-dev \
    gstreamer \
    gstreamer-dev \
 "

AV_EXTRA = " \
    libav \
    libvpx \
 "

VIVANTE_SAMPLE_CODE = " \
    gpu-viv-bin-mx6q \
    gpu-viv-bin-mx6q-dev \
 "

# install vpu firmware for both dual and quad boards on all images
VPU_FIRMWARE = " \
    firmware-imx-vpu-imx6d \
    firmware-imx-vpu-imx6q \
 "

IMAGE_INSTALL += " \
    ${GSTREAMER_PACKAGES} \
    ${VPU_FIRMWARE} \
    ${AV_EXTRA} \
 "

export IMAGE_BASENAME = "pansenti-gst-image"

