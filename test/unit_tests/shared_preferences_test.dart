import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    // Cấu hình SharedPreferences mock trước mỗi test
    SharedPreferences.setMockInitialValues({
      'test_key': 'test_value'
    });
  });

  test('SharedPreferences mock works correctly', () async {
    // Lấy instance của SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Kiểm tra xem có thể đọc giá trị từ mock không
    expect(prefs.getString('test_key'), equals('test_value'));

    // Kiểm tra xem có thể ghi giá trị mới không
    await prefs.setString('new_key', 'new_value');
    expect(prefs.getString('new_key'), equals('new_value'));
  });
}
