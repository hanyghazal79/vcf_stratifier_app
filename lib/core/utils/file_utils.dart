// file_utils.dart - UPDATED FOR WEB
class FileUtils {
  static Future<bool> isValidVCFFile(String path) async {
    // For web, we can't check file existence or content
    // Just check if it has a VCF extension
    return path.toLowerCase().endsWith('.vcf') ||
           path.toLowerCase().endsWith('.vcf.gz');
  }

  static Future<int> getFileSize(String path) async {
    // Not available on web without File API
    return 0;
  }

  static String getFileName(String path) {
    return path.split('/').last;
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }
}