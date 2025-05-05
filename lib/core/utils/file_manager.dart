// import 'dart:io';
// import 'package:exam_simulator/core/utils/log_util.dart';
// import 'package:exam_simulator/core/utils/permission_handler.dart';
// import 'package:flutter/foundation.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:file_picker/file_picker.dart';
// import '../shared/models/stored_file.dart';
// import 'package:permission_handler/permission_handler.dart'; // For platforms that need permissions
//
// class FileManager {
//   final PermissionHandler _permissionHandler = PermissionHandler();
//
//   /// Check if storage permission is required on the current platform
//   Future<bool> isPermissionRequired() async {
//     if (kIsWeb) return false;
//
//     if (Platform.isAndroid || Platform.isIOS || Platform.isWindows) {
//       return true;
//     }
//     return false; // macOS and Linux typically don't require storage permissions
//   }
//
//   /// Request storage permission if required
//   Future<bool> requestStoragePermission() async {
//     if (!(await isPermissionRequired())) return true;
//     LogUtil.debug("Requesting Storage permission....");
//
//     return await _permissionHandler.requestStoragePermission();
//   }
//
//   /// Get the application's document directory path
//   Future<String> getAppDirectory() async {
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }
//
//   /// Pick a file from the system and return a StoredFile
//   Future<PickedFile?> pickFile(bool selectQuizFile) async {
//     try {
//
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         allowMultiple: false, // Set to true for multiple files
//       );
//
//       if (kIsWeb && result != null) {
//         final bytes = result.files.single.bytes;
//         if (bytes == null) {
//           return null;
//         }
//
//         final name = result.files.single.name;
//         final size = result.files.single.size;
//         final storedFile = PickedFile.fromWeb(name, size, bytes);
//         return storedFile;
//       }
//
//       if (result != null && result.files.single.path != null) {
//         final file = File(result.files.single.path!);
//         return await PickedFile.fromFile(file);
//       }
//     } catch (e) {
//       LogUtil.debug("Error picking file: $e");
//     }
//
//     return null;
//   }
//
//   /// Save a file to the app directory and return the StoredFile of the saved file
//   Future<PickedFile?> saveFileToAppDirectory(PickedFile file) async {
//     try {
//       if (file.path == null) {
//         return null;
//       }
//       // Request storage permission if needed
//       if (await isPermissionRequired() && !await requestStoragePermission()) {
//         LogUtil.debug("Storage permission is denied.");
//         return null;
//       }
//
//       final appDir = await getAppDirectory();
//
//       final newFile = File(file.path!);
//       final fileName = newFile.path.split('/').last; // Get the file name
//       final savedFile = await newFile.copy('$appDir/$fileName'); // Copy file
//
//       LogUtil.debug('File saved at: ${savedFile.path}');
//       return await PickedFile.fromFile(savedFile);
//     } catch (e) {
//       LogUtil.debug("Error saving file: $e");
//       return null;
//     }
//   }
//
//   /// Get a list of all saved files in the app directory as StoredFile
//   Future<List<PickedFile>> getSavedFiles() async {
//     try {
//       final appDir = await getAppDirectory();
//       final dir = Directory(appDir);
//
//       if (await dir.exists()) {
//         final files = dir.listSync().whereType<File>();
//         return await Future.wait(files.map(PickedFile.fromFile));
//       } else {
//         return [];
//       }
//     } catch (e) {
//       LogUtil.debug("Error fetching saved files: $e");
//       return [];
//     }
//   }
//
//   /// Get a single file by name and return its StoredFile
//   Future<PickedFile?> getFileByName(String fileName) async {
//     try {
//       final appDir = await getAppDirectory();
//       final filePath = '$appDir/$fileName';
//       final file = File(filePath);
//
//       if (await file.exists()) {
//         return await PickedFile.fromFile(file);
//       } else {
//         LogUtil.debug("File not found: $fileName");
//         return null;
//       }
//     } catch (e) {
//       LogUtil.debug("Error fetching file by name: $e");
//       return null;
//     }
//   }
//
//   /// Get files filtered by extension as StoredFiles
//   Future<List<PickedFile>> getFilesByExtension(String extension) async {
//     try {
//       final files = await getSavedFiles();
//       return files.where((file) => file.name.endsWith(extension)).toList();
//     } catch (e) {
//       LogUtil.debug("Error filtering files by extension: $e");
//       return [];
//     }
//   }
//
//   /// Get files sorted by size (largest to smallest)
//   Future<List<PickedFile>> getFilesSortedBySize() async {
//     try {
//       final files = await getSavedFiles();
//       files.sort((a, b) => b.size.compareTo(a.size));
//       return files;
//     } catch (e) {
//       LogUtil.debug("Error sorting files by size: $e");
//       return [];
//     }
//   }
//
//   /// Delete a file by StoredFile
//   Future<bool> deleteFile(PickedFile storedFile) async {
//     try {
//       // Request storage permission if needed
//       if (await isPermissionRequired() && !await requestStoragePermission()) {
//         LogUtil.debug("Storage permission is denied.");
//         return false;
//       }
//
//       final file = File(storedFile.path!);
//       if (await file.exists()) {
//         await file.delete();
//         LogUtil.debug("File deleted: ${storedFile.name}");
//         return true;
//       } else {
//         LogUtil.debug("File not found: ${storedFile.name}");
//         return false;
//       }
//     } catch (e) {
//       LogUtil.debug("Error deleting file: $e");
//       return false;
//     }
//   }
// }
