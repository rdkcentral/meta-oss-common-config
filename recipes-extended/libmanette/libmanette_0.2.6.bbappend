FILESEXTRAPATHS:prepend := "${THISDIR}/libmanette:"

SRC_URI:append = " file://0002-add-wayland-inputfd-support.patch "

PACKAGECONFIG:append = "wayland-inputfd"
