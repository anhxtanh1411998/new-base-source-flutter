import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Helper class để cấu hình môi trường test
class TestHelper {
  /// Cấu hình SharedPreferences cho test
  static Future<void> setupSharedPreferences() async {
    // Thiết lập SharedPreferences.setMockInitialValues cho test
    SharedPreferences.setMockInitialValues({});
  }

  /// Cấu hình test environment chung
  static Future<void> setupTestEnvironment() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await setupSharedPreferences();
  }
}
