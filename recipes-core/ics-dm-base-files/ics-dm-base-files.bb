SUMMARY = "ICS DM Base Files"
DESCRIPTION = "Provide ICS DM Base Files."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "\
    file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
"

SRC_URI = "\
    file://etc/sudoers.d/001_ics-dm \
    file://etc/profile.d/ics-dm_profile.sh \
"

FILES_${PN} = "\
    /etc/sudoers.d/001_ics-dm \
    /etc/profile.d/ics-dm_profile.sh \
    /mnt/data \
    /mnt/etc \
    /var/lib \
    ${exec_prefix}/local \
"

do_install() {
    install -d ${D}/etc/sudoers.d/
    install -d ${D}/etc/profile.d/
    install -m 0644 ${WORKDIR}/etc/sudoers.d/001_ics-dm ${D}/etc/sudoers.d/
    install -m 0644 ${WORKDIR}/etc/profile.d/ics-dm_profile.sh ${D}/etc/profile.d/

    # install mountpoints
    install -d -D ${D}/mnt/data \
    install -d -D ${D}/mnt/etc \
    install -d -D ${D}/var/lib \
    install -d -D ${D}${exec_prefix}/local
}