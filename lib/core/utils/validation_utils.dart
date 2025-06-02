/// A utility class for form validation
class ValidationUtil {
  /// Validate if a string is not empty
  static String? validateRequired(String? value, {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  /// Validate email format
  static String? validateEmail(String? value, {String message = 'Please enter a valid email address'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return message;
    }
    
    return null;
  }

  /// Validate password strength
  /// Password must be at least 8 characters long and contain at least one uppercase letter,
  /// one lowercase letter, one number, and one special character
  static String? validatePassword(String? value, {
    String message = 'Password must be at least 8 characters with uppercase, lowercase, number, and special character',
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumber = true,
    bool requireSpecialChar = true,
    int minLength = 8,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters long';
    }
    
    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    
    if (requireNumber && !value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    if (requireSpecialChar && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    
    return null;
  }

  /// Validate if two passwords match
  static String? validatePasswordMatch(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return 'Confirm password is required';
    }
    
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  /// Validate phone number format
  static String? validatePhone(String? value, {String message = 'Please enter a valid phone number'}) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    
    // Basic phone validation - can be customized for specific country formats
    final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    
    if (!phoneRegex.hasMatch(value)) {
      return message;
    }
    
    return null;
  }

  /// Validate URL format
  static String? validateUrl(String? value, {String message = 'Please enter a valid URL'}) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required';
    }
    
    final RegExp urlRegex = RegExp(
      r'^(http|https)://[a-zA-Z0-9-_]+(\.[a-zA-Z0-9-_]+)+(:[0-9]+)?(/[a-zA-Z0-9-_.]*)*(\?[a-zA-Z0-9-_]+=[a-zA-Z0-9-_]+(&[a-zA-Z0-9-_]+=[a-zA-Z0-9-_]+)*)?$',
    );
    
    if (!urlRegex.hasMatch(value)) {
      return message;
    }
    
    return null;
  }

  /// Validate minimum length
  static String? validateMinLength(String? value, int minLength, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    
    if (value.length < minLength) {
      return message ?? 'Must be at least $minLength characters long';
    }
    
    return null;
  }

  /// Validate maximum length
  static String? validateMaxLength(String? value, int maxLength, {String? message}) {
    if (value == null) {
      return null;
    }
    
    if (value.length > maxLength) {
      return message ?? 'Must be at most $maxLength characters long';
    }
    
    return null;
  }
}