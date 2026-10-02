#!/system/bin/sh

MODDIR=${0%/*}
SOURCE="$MODDIR/files/liboemcrypto.so"
TARGET=/vendor/lib64/liboemcrypto.so

[ -f "$SOURCE" ] && [ ! -s "$SOURCE" ] && [ -f "$TARGET" ] || exit 1

if grep -q " $TARGET " /proc/1/mountinfo; then
  [ ! -s "$TARGET" ]
  exit $?
fi

mount -o bind "$SOURCE" "$TARGET" || exit 1
grep -q " $TARGET " /proc/1/mountinfo || exit 1
[ ! -s "$TARGET" ]
