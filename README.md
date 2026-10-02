# OEMCrypto Disabler

This KernelSU module substitutes an empty file for `/vendor/lib64/liboemcrypto.so` while root is active. It can make some streaming apps choose a non-secure video decoder. It does not modify the vendor partition or patch `services.jar`.

## Requirements

- KernelSU or KernelSU Next with module scripts enabled.
- An arm64 device with `/vendor/lib64/liboemcrypto.so`. The installer checks for this file. Other library locations and 32-bit-only devices are not supported by this release.
- For screenshots or screen recording, a separate working hook may also be needed if the app marks its video surface secure. This module changes the decoder path; it does not remove screenshot flags.

Tested on Samsung Galaxy S26 Ultra (SM-S948B), One UI 8.5, Android 16. Playback behavior on other devices and firmware is not guaranteed.

## Install and use

1. Install `oemcrypto-disabler-v1.0-by-alqaisi9.zip` in KernelSU.
2. A new install may show as pending until the next normal restart and KernelSU load. If your root uses late-load, run it again after that restart. Do not use a soft reboot just to activate this module.
3. Close and reopen the streaming app, then test playback. If you also use a screenshot hook, test capture separately.

On later loads, KernelSU should apply the module automatically. Once active, the module's **Action** button can reapply the overlay and attempt to refresh Widevine if an app still uses a secure decoder. Reopen the app afterward; on some devices, a normal reboot may be needed instead.

## Tradeoffs and removal

The Widevine security level may fall, picture quality may drop, or playback may fail. Other DRM apps can also be affected while the module is active.

**Use this module at your own risk and responsibility.** The author is not responsible for a bricked device, boot problems, data loss, or other damage caused by installing or using this module.

To restore stock behavior, disable or uninstall the module in KernelSU and perform a **normal reboot**. A reboot clears the live bind mount, and KernelSU will not reapply a disabled or removed module. If you use temporary root, you may then run your normal root setup again without this module. The original vendor library is never overwritten; KernelSU removes the module's files when it processes the uninstall at its next load.

Disabling or uninstalling does **not** immediately undo a bind mount already active in the current session. Immediate rollback without reboot requires a root shell to verify that this module owns the mount, unmount `/vendor/lib64/liboemcrypto.so`, restart the device's Widevine service, and reopen affected apps. The service name varies by device.

The ZIP contains no firmware patch, stock OEMCrypto library, or DRM keys.
