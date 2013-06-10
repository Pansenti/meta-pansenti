# A dev image with Qt embedded

require pansenti-console-image.bb

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
    syntrov4lcamera \
 "

IMAGE_INSTALL += " \
    ${QT_TOOLS} \
    ${PSPLASH} \
    ${SYNTRO} \
 "

export IMAGE_BASENAME = "pansenti-qte-image"

