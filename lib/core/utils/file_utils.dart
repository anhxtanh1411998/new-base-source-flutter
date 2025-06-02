import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;

/// A utility class for file operations
class FileUtil {
  /// Get the file extension from a file path
  static String getFileExtension(String filePath) {
    return filePath.split('.').last;
  }

  /// Get the file name from a file path
  static String getFileName(String filePath) {
    return filePath.split('/').last;
  }

  /// Get the file size in a human-readable format
  static String getFileSize(File file, {int decimals = 1}) {
    int bytes = file.lengthSync();
    if (bytes <= 0) return '0 B';

    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    var i = (log(bytes) / log(1024)).floor();

    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  /// Get the MIME type of a file
  static String? getMimeType(String filePath) {
    return lookupMimeType(filePath);
  }

  /// Check if a file is an image
  static bool isImage(String filePath) {
    final mimeType = getMimeType(filePath);
    return mimeType != null && mimeType.startsWith('image/');
  }

  /// Check if a file is a video
  static bool isVideo(String filePath) {
    final mimeType = getMimeType(filePath);
    return mimeType != null && mimeType.startsWith('video/');
  }

  /// Check if a file is an audio
  static bool isAudio(String filePath) {
    final mimeType = getMimeType(filePath);
    return mimeType != null && mimeType.startsWith('audio/');
  }

  /// Check if a file is a document (pdf, doc, docx, xls, xlsx, ppt, pptx)
  static bool isDocument(String filePath) {
    final extension = getFileExtension(filePath).toLowerCase();
    return ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx'].contains(extension);
  }

  /// Get the application documents directory
  static Future<Directory> getDocumentsDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  /// Get the application temporary directory
  static Future<Directory> getTemporaryDirectory() async {
    return await getTemporaryDirectory();
  }

  /// Download a file from a URL and save it to the specified path
  static Future<File> downloadFile(String url, String savePath) async {
    final response = await http.get(Uri.parse(url));
    final file = File(savePath);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  /// Create a temporary file with the given data
  static Future<File> createTempFile(List<int> data, {String? extension}) async {
    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = '${tempDir.path}/$timestamp${extension != null ? '.$extension' : ''}';
    final file = File(path);
    await file.writeAsBytes(data);
    return file;
  }

  /// Delete a file
  static Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Check if a file exists
  static Future<bool> fileExists(String filePath) async {
    return await File(filePath).exists();
  }

  /// Create a directory if it doesn't exist
  static Future<Directory> createDirectory(String path) async {
    final directory = Directory(path);
    if (!(await directory.exists())) {
      await directory.create(recursive: true);
    }
    return directory;
  }
}
