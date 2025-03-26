FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}_${PV}:"

SRC_URI:append = " file://bluez-5.48-kirkstone_compile_errors.patch "

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://breakpad.patch"
SRC_URI += "file://0001-Fix-race-issue-with-tools-directory.patch \
            file://0001-testtools-fix-SIOCGSTAMP-undeclared-error.patch \
            file://CVE-2019-8922.patch \
            file://CVE-2020-27153.patch \
            file://CVE-2022-0204.patch \
            file://CVE-2020-0556.patch \
            file://CVE-2018-10910.patch \
            file://CVE-2018-10910_I.patch \
            file://CVE-2019-8921.patch \
            file://CVE-2022-39176_5.48_fix.patch \
            file://CVE-2022-39177_5.48_fix.patch \
            file://CVE-2023-45866.patch \
            "
# Removed testtools package as it has a depedncy with python
PACKAGES:remove = "${PN}-testtools"

# Add DISTRO_FEATURES:append = ' blueztest' in rdke-distros.inc if we need to add ${PN}-testtools
PACKAGES += "${@bb.utils.contains('DISTRO_FEATURES', 'blueztest', '${PN}-testtools', '', d)}"

do_install:append() {
    #Files inside /usr/lib/bluez are test files. These are required only when PACKAGE ${PN}-testtools is added. Without the packages, these files are not required and observing package_qa error since the files are not shipped. Remove it unless the distro is defined.
    if ${@bb.utils.contains('DISTRO_FEATURES', 'blueztest', 'false', 'true', d)}; then
        rm -rf ${D}${libdir}/bluez
    fi
}


