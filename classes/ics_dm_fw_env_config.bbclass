DEPENDS += "bc-native"

# multiply with 1024; convert to hex
ics_dm_conv_size_param() {
    local param="$1"
    local  name="$2"
    if [ -z "${param}" ]; then bbfatal "invalid parameter passed for ${name}"; fi
    param="$(echo "${param} * 1024" | bc)"
    param="0x$(printf '%x' ${param})"
    if [ -z "${param}" ]; then bbfatal "parameter conversion error for ${name}"; fi
    echo ${param}
}

# generate fw_env.config based on on distro configuration
ics_dm_generate_fw_env_config() {
    local  blk_dev="/dev/mmcblk0"
    local env_size=$(ics_dm_conv_size_param "${ICS_DM_PART_SIZE_UBOOT_ENV}"    "u-boot env. size")
    local  offset1=$(ics_dm_conv_size_param "${ICS_DM_PART_OFFSET_UBOOT_ENV1}" "u-boot env. offset1")
    local  offset2=$(ics_dm_conv_size_param "${ICS_DM_PART_OFFSET_UBOOT_ENV2}" "u-boot env. offset2")
    rm -f ${D}${sysconfdir}/fw_env.config
    echo "# Generated by ${PN} bbappend"      >${WORKDIR}/fw_env.config
    echo "${blk_dev} ${offset1} ${env_size}" >>${WORKDIR}/fw_env.config
    echo "${blk_dev} ${offset2} ${env_size}" >>${WORKDIR}/fw_env.config
    install -m 0644 -D ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}