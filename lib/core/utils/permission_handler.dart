import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  /// Check if a specific permission is granted
  Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  /// Request a specific permission
  Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  /// Check and request permission (combined flow)
  Future<bool> checkAndRequestPermission(Permission permission) async {
    if (await isPermissionGranted(permission)) {
      return true;
    }

    await openAppSettingsIfDenied(permission);
    return await requestPermission(permission);
  }

  /// Request multiple permissions at once
  Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
      List<Permission> permissions) async {
    return await permissions.request();
  }

  /// Check if a permission is permanently denied
  Future<bool> isPermissionPermanentlyDenied(Permission permission) async {
    return await permission.isPermanentlyDenied;
  }

  /// Open the app settings if permission is permanently denied
  Future<void> openAppSettingsIfDenied(Permission permission) async {
    if (await isPermissionPermanentlyDenied(permission)) {
      await openAppSettings();
    }
  }

  /// Check and request storage permission
  Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      // Prompt user to open app settings if permission is permanently denied
      await openAppSettings();
    }
    return false;
  }


  /// Check and request camera permission
  Future<bool> requestCameraPermission() async {
    return await checkAndRequestPermission(Permission.camera);
  }

  /// Check and request location permission
  Future<bool> requestLocationPermission() async {
    return await checkAndRequestPermission(Permission.location);
  }

  /// Check and request notifications permission (iOS only)
  Future<bool> requestNotificationPermission() async {
    return await checkAndRequestPermission(Permission.notification);
  }

  /// Check and request photos permission (iOS only)
  Future<bool> requestPhotosPermission() async {
    return await checkAndRequestPermission(Permission.photos);
  }
}
