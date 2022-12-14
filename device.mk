#
# Copyright (C) 2020 Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/oppo/CPH2293

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Inherit dalvik-heap device configs for 12 GiB devices 
$(call inherit-product, frameworks/native/build/phone-xhdpi-12288-dalvik-heap.mk)

PRODUCT_SHIPPING_API_LEVEL := 30

# Call proprietary blob setup
$(call inherit-product-if-exists, vendor/oppo/CPH2293/CPH2293-vendor.mk)

$(call inherit-product, vendor/oppo/IMS-CPH2293/mtk-ims.mk)

# Dynamic Partition
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# A/B
AB_OTA_UPDATER := false

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/oppo/CPH2293/bluetooth/include

# Bluetooth Audio (System-side HAL, sysbta)
PRODUCT_PACKAGES += \
    audio.sysbta.default \
    android.hardware.bluetooth.audio-service-system

PRODUCT_COPY_FILES += \
    device/oppo/CPH2293/bluetooth/audio/config/sysbta_audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysbta_audio_policy_configuration.xml \
    device/oppo/CPH2293/bluetooth/audio/config/sysbta_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysbta_audio_policy_configuration_7_0.xml

# VNDK
PRODUCT_EXTRA_VNDK_VERSIONS := 30
	
# Dex/ART optimization
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := everything
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true
USE_DEX2OAT_DEBUG := false

PRODUCT_DEXPREOPT_SPEED_APPS += \
    Settings \
    SystemUI

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.CPH2293

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.fingerprint.xml

# HIDL
PRODUCT_PACKAGES += \
    libhidltransport \
    libhardware \
    libhwbinder

# ImsInit hack
PRODUCT_PACKAGES += \
    ImsInit

# Init
PRODUCT_PACKAGES += \
    init.mt6893.rc \
    fstab.mt6893

# NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    com.gsma.services.nfc  \
    NfcNci \
    SecureElement \
    Tag

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/nfc/libnfc-nxp-pnscr.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/libnfc-nxp-pnscr.conf \
    $(LOCAL_PATH)/nfc/libnfc-mtp-SN100.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/libnfc-mtp-SN100.conf \
    $(LOCAL_PATH)/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/libnfc-nci.conf

# Screen density
PRODUCT_AAPT_CONFIG := xxxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.CPH2293

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay \
    $(DEVICE_PATH)/overlay-aosp

# MTK InCallService
PRODUCT_PACKAGES += \
    MtkInCallService

# Permissions
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/permissions/privapp-permissions-mediatek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-mediatek.xml

# Ramdisk
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/vendor_overlay/etc/fstab.mt6893:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6893

# RcsService
PRODUCT_PACKAGES += \
    com.android.ims.rcsmanager \
    RcsService \
    PresencePolling

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# System prop
-include $(DEVICE_PATH)/system_prop.mk
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# Symbols
PRODUCT_PACKAGES += \
    libshim_vtservice

# Telephony
PRODUCT_PACKAGES += \
    ImsServiceBase

# Vendor overlay
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/vendor_overlay/,$(TARGET_COPY_OUT_PRODUCT)/vendor_overlay/30/)

# Wi-Fi
PRODUCT_PACKAGES += \
    TetheringConfigOverlay \
    WifiOverlay \
    DozeOverlaySystem \
    DozeOverlaySystemUI
