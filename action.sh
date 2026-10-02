#!/system/bin/sh

MODDIR=${0%/*}

if ! sh "$MODDIR/post-mount.sh"; then
  echo "OEMCrypto overlay was not applied. Check for /vendor/lib64/liboemcrypto.so."
  exit 1
fi

if ! sh "$MODDIR/service.sh"; then
  echo "Overlay is present, but the Widevine service could not be refreshed."
  exit 1
fi

echo "OEMCrypto fallback is active. Close and reopen the streaming app."
