#!/system/bin/sh

TARGET=/vendor/lib64/liboemcrypto.so

grep -q " $TARGET " /proc/1/mountinfo || exit 1
[ ! -s "$TARGET" ] || exit 1

if [ "$(getprop init.svc.vendor.drm-widevine-hal)" = running ]; then
  setprop ctl.restart vendor.drm-widevine-hal
fi
