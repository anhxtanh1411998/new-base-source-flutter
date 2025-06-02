/// A utility class for string operations
class StringUtil {
  /// Capitalize the first letter of a string
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Truncate a string to a specified length and add ellipsis if needed
  static String truncate(String text, int maxLength, {String ellipsis = '...'}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}$ellipsis';
  }

  /// Remove all HTML tags from a string
  static String removeHtmlTags(String htmlString) {
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }

  /// Check if a string is a valid email
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Check if a string is a valid URL
  static bool isValidUrl(String url) {
    final RegExp urlRegex = RegExp(
      r'^(http|https)://[a-zA-Z0-9-_]+(\.[a-zA-Z0-9-_]+)+(:[0-9]+)?(/[a-zA-Z0-9-_.]*)*(\?[a-zA-Z0-9-_]+=[a-zA-Z0-9-_]+(&[a-zA-Z0-9-_]+=[a-zA-Z0-9-_]+)*)?$',
    );
    return urlRegex.hasMatch(url);
  }

  /// Convert a string to camelCase
  static String toCamelCase(String text) {
    if (text.isEmpty) return text;
    
    final words = text.split(RegExp(r'[_\s-]+'));
    final result = StringBuffer(words[0].toLowerCase());
    
    for (var i = 1; i < words.length; i++) {
      final word = words[i];
      if (word.isNotEmpty) {
        result.write(word[0].toUpperCase() + word.substring(1).toLowerCase());
      }
    }
    
    return result.toString();
  }

  /// Convert a string to snake_case
  static String toSnakeCase(String text) {
    if (text.isEmpty) return text;
    
    final result = StringBuffer();
    
    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      if (char == ' ' || char == '-') {
        result.write('_');
      } else if (char.toUpperCase() == char && i > 0 && text[i - 1] != ' ' && text[i - 1] != '_') {
        result.write('_${char.toLowerCase()}');
      } else {
        result.write(char.toLowerCase());
      }
    }
    
    return result.toString();
  }
}