#marble
# Copyright (C) 2023 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit virtual_ab_ota_product.
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Setup dalvik vm configs.
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Call the proprietary setup.
$(call inherit-product, vendor/xiaomi/mondrian/mondrian-vendor.mk)

# Enable updating of APEXes.
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Project ID Quota.
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

DEVICE_PATH := device/xiaomi/mondrian

# API
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_TARGET_VNDK_VERSION := 32
PRODUCT_EXTRA_VNDK_VERSIONS := 30 31 32

# Platform
TARGET_BOARD_PLATFORM := taro

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# AIDL NDK backend
PRODUCT_PACKAGES += \
    android.hardware.common-V2-ndk_platform \
    android.hardware.gnss-V1-ndk_platform \
    android.hardware.identity-V3-ndk_platform \
    android.hardware.keymaster-V3-ndk_platform \
    android.hardware.light-V1-ndk_platform \
    android.hardware.memtrack-V1-ndk_platform \
    android.hardware.security.keymint-V1-ndk_platform \
    android.hardware.security.secureclock-V1-ndk_platform \
    android.hardware.security.sharedsecret-V1-ndk_platform

# Atrace
PRODUCT_PACKAGES += \
    android.hardware.atrace@1.0-service
    
# Audio
SOONG_CONFIG_NAMESPACES += android_hardware_audio
SOONG_CONFIG_android_hardware_audio += \
    run_64bit
SOONG_CONFIG_android_hardware_audio_run_64bit := true

PRODUCT_PACKAGES += \
    android.hardware.audio.service.rc \
    audio.primary.$(TARGET_BOARD_PLATFORM) \
    audio.usb.$(TARGET_BOARD_PLATFORM)

PRODUCT_PACKAGES += \
    android.hardware.audio@7.0-impl \
    android.hardware.audio.effect@7.0-impl \
    android.hardware.audio.service \
    android.hardware.soundtrigger@2.3-impl

PRODUCT_PACKAGES += \
    audio.bluetooth.default \
    audio.r_submix.default \
    audio.usb.default

PRODUCT_PACKAGES += \
    libvolumelistener

# Automotive
PRODUCT_PACKAGES += \
    android.hardware.automotive.vehicle@2.0-manager-lib

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0 \
    android.hardware.bluetooth.audio-impl \
    com.qualcomm.qti.bluetooth_audio@1.0 \
    vendor.qti.hardware.bluetooth_audio@2.1 \
    vendor.qti.hardware.btconfigstore@1.0 \
    vendor.qti.hardware.btconfigstore@2.0

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl-qti \
    android.hardware.boot@1.2-impl-qti.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# Camera
$(call inherit-product, vendor/xiaomi/camera/miuicamera.mk)

PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.7.vendor \
    camera.device@1.0-impl \
    libcamera2ndk_vendor \
    vendor.qti.hardware.camera.aon@1.0.vendor \
    vendor.qti.hardware.camera.postproc@1.0.vendor

PRODUCT_PACKAGES += \
    libMegviiFacepp-0.5.2 \
    libmegface
    
PRODUCT_SYSTEM_PROPERTIES += \
    ro.miui.notch=1 \
    ro.product.mod_device=mondrian

# Capabilityconfigstore
PRODUCT_PACKAGES += \
    vendor.qti.hardware.capabilityconfigstore@1.0

# Dolby
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/audio/dolby/dax-default.xml:$(TARGET_COPY_OUT_ODM)/etc/dolby/dax-default.xml \
    $(DEVICE_PATH)/audio/dolby/config-com.dolby.daxappui.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/config-com.dolby.daxappui.xml \
    $(DEVICE_PATH)/audio/dolby/config-com.dolby.daxservice.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/config-com.dolby.daxservice.xml \
    $(DEVICE_PATH)/audio/dolby/hiddenapi-com.dolby.daxservice.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/hiddenapi-com.dolby.daxservice.xml \
    $(DEVICE_PATH)/audio/dolby/privapp-com.dolby.daxappui.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-com.dolby.daxappui.xml \
    $(DEVICE_PATH)/audio/dolby/privapp-com.dolby.daxservice.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-com.dolby.daxservice.xml

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.sensor.pickup=xiaomi.sensor.pickup \
    ro.sensor.pickup.lower.value=2 \
    ro.sensor.proximity=true

# Dtb
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/prebuilts/dtb:dtb.img

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4-service.clearkey \
    libdrm.vendor

# Dumpstate
PRODUCT_PACKAGES += \
    android.hardware.dumpstate@1.1

# F2FS utilities
PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.mondrian \
    libudfpshandler

PRODUCT_SYSTEM_PROPERTIES += \
    ro.hardware.fingerprint.fpc_fod=default \
    ro.hardware.fingerprint.goodix_fod=default

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@2.1 \
    android.hardware.power@1.2 \
    libgrpc++_unsecure
    
# Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.4 \
    libgralloc.qti \
    libgui_vendor \
    libqdMetaData \
    vendor.display.config@1.11 \
    vendor.qti.hardware.display.allocator@1.0 \
    vendor.qti.hardware.display.allocator@3.0 \
    vendor.qti.hardware.display.allocator@4.0 \
    vendor.qti.hardware.display.composer@1.0 \
    vendor.qti.hardware.display.composer@2.0 \
    vendor.qti.hardware.display.composer@3.1 \
    vendor.qti.hardware.display.config-V1-ndk_platform \
    vendor.qti.hardware.display.config-V2-ndk_platform \
    vendor.qti.hardware.display.config-V3-ndk_platform \
    vendor.qti.hardware.display.config-V4-ndk_platform \
    vendor.qti.hardware.display.config-V5-ndk_platform \
    vendor.qti.hardware.display.config-V6-ndk_platform \
    vendor.qti.hardware.display.demura@2.0 \
    vendor.qti.hardware.display.mapper@1.0 \
    vendor.qti.hardware.display.mapper@2.0 \
    vendor.qti.hardware.display.mapper@3.0 \
    vendor.qti.hardware.display.mapper@4.0 \
    vendor.qti.hardware.display.mapperextensions@1.2

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl-qti \
    android.hardware.health@2.1-service

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.allocator@1.0 \
    android.hidl.memory.block@1.0 \
    libhidltransport \
    libhwbinder

# Hotword Enrollement
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/privapp-permissions-hotword.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-hotword.xml
    
# IPACM
PRODUCT_PACKAGES += \
    ipacm \
    IPACM_cfg.xml \
    IPACM_Filter_cfg.xml

# IR
PRODUCT_PACKAGES += \
    android.hardware.ir@1.0-impl \
    android.hardware.ir@1.0-service

# JSON
PRODUCT_PACKAGES += \
    libjson

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.1 \
    libkeymaster_messages

# Media
PRODUCT_PACKAGES += \
    libcodec2_hidl@1.0 \
    libcodec2_soft_common \
    libsfplugin_ccodec_utils

# MultiGen LRU
PRODUCT_SYSTEM_PROPERTIES += \
    persist.device_config.mglru_native.lru_gen_config=all

# Network
PRODUCT_PACKAGES += \
    android.system.net.netd@1.1

# Neural networks
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks-V1-ndk_platform

# NFC
PRODUCT_PACKAGES += \
    NfcNci \
    Tag \
    SecureElement \
    com.android.nfc_extras

# Overlays  
PRODUCT_PACKAGES += \
    AospWifiResOverlayMondrian \
    CarrierConfigResCommon \
    FrameworksResCommon \
    FrameworksResOverlayMondrian \
    SettingsOverlayMondrian \
    SettingsResCommon \
    SystemUIOverlayMondrian \
    SystemUIResCommon \
    TelecommResCommon \
    TelephonyResCommon \
    WifiResCommon

PRODUCT_PACKAGES += \
    AospWifiResOverlayMondrianChina \
    AospWifiResOverlayMondrianGlobal \
    SettingsOverlayGlobal \
    SettingsOverlayChina \
    SettingsProviderOverlayChina \
    SettingsProviderOverlayGlobal

DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-lineage
	
# Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Parts
PRODUCT_PACKAGES += \
    XiaomiParts

# Perf
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0 \
    libavservices_minijail \
    libtflite \
    vendor.qti.hardware.perf@2.3

PRODUCT_BOOT_JARS += \
    QPerformance \
    QXPerformance \
    UxPerformance

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.xiaomi-libperfmgr

# Properties
include $(DEVICE_PATH)/configs/properties/default.mk

# RIL
PRODUCT_PACKAGES += \
    Ims \
    QtiTelephony \
    qti-telephony-common

# Rootdir
PRODUCT_PACKAGES += \
    init.recovery.qcom.rc \
    init.qcom.rc

# Secure element
PRODUCT_PACKAGES += \
    android.hardware.secure_element@1.2

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.xiaomi-multihal \
    libsensorndkbridge \
    sensors.xiaomi

# Servicetracker
PRODUCT_PACKAGES += \
    vendor.qti.hardware.servicetracker@1.2

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH) \
    hardware/xiaomi

# Storage
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.fuse.passthrough.enable=true

# Speed profile services and wifi-service to reduce RAM and storage
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile

# Telephony
PRODUCT_PACKAGES += \
    extphonelib \
    extphonelib-product \
    extphonelib.xml \
    extphonelib_product.xml \
    ims-ext-common \
    ims_ext_common.xml \
    qti-telephony-hidl-wrapper \
    qti-telephony-hidl-wrapper-prd \
    qti_telephony_hidl_wrapper.xml \
    qti_telephony_hidl_wrapper_prd.xml \
    qti-telephony-utils \
    qti-telephony-utils-prd \
    qti_telephony_utils.xml \
    qti_telephony_utils_prd.xml \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@2.0.vendor

# Update engine
PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# USAP Pool
PRODUCT_SYSTEM_PROPERTIES += \
    persist.device_config.runtime_native.usap_pool_enabled=true

PRODUCT_BOOT_JARS += \
    WfdCommon

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    debug.sf.enable_hwc_vds=1 \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0

