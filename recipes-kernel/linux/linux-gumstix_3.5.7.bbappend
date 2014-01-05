FILESEXTRAPATHS_prepend := "${THISDIR}/linux-gumstix-3.5:"

PRINC := "${@int(PRINC) + 1}"

SRC_URI += "file://fix-evsel-include-path-for-perf-recipe.patch"


