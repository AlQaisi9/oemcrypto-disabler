#!/system/bin/sh

[ "$ARCH" = arm64 ] || abort "This package requires an arm64 device."
[ -f /vendor/lib64/liboemcrypto.so ] || abort "This device does not have /vendor/lib64/liboemcrypto.so."
[ -f "$MODPATH/files/liboemcrypto.so" ] && [ ! -s "$MODPATH/files/liboemcrypto.so" ] || abort "The empty OEMCrypto file is missing or not empty."

set_perm "$MODPATH/post-mount.sh" 0 0 0755
set_perm "$MODPATH/service.sh" 0 0 0755
set_perm "$MODPATH/action.sh" 0 0 0755
set_perm "$MODPATH/files/liboemcrypto.so" 0 0 0644
