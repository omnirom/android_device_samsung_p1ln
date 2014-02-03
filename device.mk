#
# Copyright (C) 2008 The Android Open-Source Project
# Copyright (C) 2013 OmniROM Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This file is the device-specific product definition file for P1000 devices. 
# It lists all the overlays, files, modules and properties that are specific 
# to this hardware: i.e. those are device-specific drivers, configuration 
# files, settings, etc...
#
# Note that P1000 is not a fully open device. Some of the drivers aren't publicly
# available, which means that some of the hardware capabilities aren't present 
# in builds where those drivers aren't available. Such cases are handled by having
# the configuration separated into two halves: this half here contains the parts
# that are available to everyone, while another half in the vendor/ hierarchy 
# augments that set with the parts that are only relevant when all the associated
# drivers are available. Aspects that are irrelevant but harmless in no-driver
# builds should be kept here for simplicity and transparency. 

# Device specific configuration
# This is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.
DEVICE_PACKAGE_OVERLAYS := device/samsung/p1ln/overlay

# Inherit device configuration common between GSM & CDMA products.
$(call inherit-product, device/samsung/p1-common/device_base.mk)

# Inherit VENDOR blobs and configuration.
# There are two variants of the half that deals with the unavailable drivers: one
# is directly checked into the unreleased vendor tree and is used by engineers who
# have access to it. The other is generated by setup-makefile.sh in the same
# directory as this files, and is used by people who have access to binary versions 
# of the drivers but not to the original vendor tree. Be sure to update both.
$(call inherit-product-if-exists, vendor/samsung/p1/p1-vendor.mk)

# Inherit from other products - most specific first
$(call inherit-product, $(SRC_TARGET_DIR)/product/full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# P1LN Init files
PRODUCT_COPY_FILES += \
	device/samsung/p1ln/rootdir/init.p1ln.rc:root/init.p1ln.rc \
	device/samsung/p1-common/rootdir/ueventd.rc:root/ueventd.p1ln.rc \
	device/samsung/p1-common/rootdir/init.recovery.rc:root/init.recovery.p1ln.rc \
	device/samsung/p1ln/rootdir/init.p1ln.usb.rc:root/init.p1ln.usb.rc \
	device/samsung/p1ln/rootdir/init.p1ln.usb.rc:recovery/root/usb.rc \
	device/samsung/p1ln/fstab.p1ln:root/fstab.p1ln

# TWRP
PRODUCT_COPY_FILES += \
	device/samsung/p1ln/twrp.fstab:recovery/root/etc/twrp.fstab

# RIL
# Permissions
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

# Device-specific packages
PRODUCT_PACKAGES += \
	SamsungServiceMode

# Hdmi
# PRODUCT_PACKAGES += \
#	hdmi.s5pc110

# Build.prop overrides
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.call_ring.delay=3000 \
    ro.telephony.call_ring.absent=true \
    mobiledata.interfaces=pdp0,wlan0,gprs \
    ro.telephony.ril.v3=icccardstatus,datacall,signalstrength,facilitylock \
    ro.ril.hsxpa=1 \
    ro.ril.gprsclass=10 \
    ro.adb.qemud=1 \
    ro.ril.enable.managed.roaming=1 \
    ro.ril.oem.nosim.ecclist=911,112,999,000,08,118,120,122,110,119,995 \
    ro.ril.emc.mode=2 \
    rild.libpath=/system/lib/libsec-ril.so \
    rild.libargs=-d/dev/ttyS0 \
    ro.phone_storage=1 \
    ro.additionalmounts=/storage/sdcard1

# Set here product definitions that valid for all p1 products
PRODUCT_BRAND := Samsung
PRODUCT_MANUFACTURER := Samsung

# Set build fingerprint / ID / product name etc.
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=GT-P1000L \
    TARGET_DEVICE=GT-P1000L \
    BUILD_FINGERPRINT=samsung/GT-P1000L/GT-P1000L:2.3.6/GINGERBREAD/VIJR2:user/release-keys \
    PRIVATE_BUILD_DESC="GT-P1000L-user 2.3.6 GINGERBREAD VIJR2 release-keys"
