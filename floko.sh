#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later

path_to_patches="$(pwd)"
build_home="${HOME}/android/floko"

cd ${build_home}/bootable/recovery
echo ">> [$(date)] Applying the patch to bootable/recovery"
git apply -p1 "${path_to_patches}/bootable-recovery.diff"

cd ${build_home}/build/make
echo ">> [$(date)] Applying the patch to build/make"
patch --quiet --force -p1 -i "${path_to_patches}/build-make.patch"

cd ${build_home}/build/soong
echo ">> [$(date)] Applying the patch to build/soong"
patch --quiet --force -p1 -i "${path_to_patches}/build-soong.patch"

cd ${build_home}/frameworks/base
echo ">> [$(date)] Applying the patch to frameworks/base"
patch --quiet --force -p1 -i "${path_to_patches}/frameworks-base.patch"
# This is workaround; If the patch failed because something changed in upstream, remove this file anyway.
echo ">> [$(date)] Removing PixelPropsUtils.java"
git rm core/java/com/android/internal/util/crdroid/PixelPropsUtils.java

cd ${build_home}/lineage-sdk
echo ">> [$(date)] Applying the patch to lineage-sdk"
patch --quiet --force -p1 -i "${path_to_patches}/lineage-sdk.patch"
find lineage/res/res/values*/strings.xml -type f | xargs sed -i -e "s/crDroid/FlokoROM/g"

cd ${build_home}/packages/apps/crDroidSettings
echo ">> [$(date)] Applying the patch to packages/apps/crDroidSettings"
patch --quiet --force -p1 -i "${path_to_patches}/packages-apps-crDroidSettings.patch"

cd ${build_home}/packages/apps/LineageParts
echo ">> [$(date)] Applying the patch to packages/apps/LineageParts"
patch --quiet --force -p1 -i "${path_to_patches}/packages-apps-LineageParts.patch"
find res/values*/strings.xml -type f | xargs sed -i -e "s/crDroid/FlokoROM/g"

cd ${build_home}/packages/apps/Settings
echo ">> [$(date)] Applying the patch to packages/apps/Settings"
git apply -p1 "${path_to_patches}/packages-apps-Settings.diff"

cd ${build_home}/packages/apps/SetupWizard
echo ">> [$(date)] Applying the patch to packages/apps/SetupWizard"
git apply -p1 "${path_to_patches}/packages-apps-SetupWizard.diff"
find res/values*/strings.xml -type f | xargs sed -i -e "s/crDroid/FlokoROM/g"

cd ${build_home}/vendor/addons
echo ">> [$(date)] Applying the patch to vendor/addons"
git apply -p1 "${path_to_patches}/vendor-addons.diff"

cd ${build_home}/vendor/lineage
echo ">> [$(date)] Applying the patch to vendor/lineage"
patch --quiet --force -p1 -i "${path_to_patches}/vendor-lineage.patch"
# This is workaround; If the patch failed because something changed in upstream, remove this file anyway.
echo ">> [$(date)] Removing version.mk"
git rm config/version.mk
