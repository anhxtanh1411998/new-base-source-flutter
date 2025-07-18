# Testing Guide

## Setup

Dự án này sử dụng các thư viện testing sau:
- `flutter_test`: Testing framework của Flutter
- `mockito`: Library mocking
- `bloc_test`: Testing BLoC pattern

## Cấu trúc thư mục test

```
test/
├── helpers/         # Các utility functions để hỗ trợ testing
├── mocks/           # Các mock objects
├── widget_tests/    # Widget tests
└── README.md        # Tài liệu hướng dẫn testing
```

## Hướng dẫn chạy tests

### Chạy tất cả tests

```bash
flutter test
```

### Chạy một file test cụ thể

```bash
flutter test test/widget_tests/home_widget_test.dart
```
# Hướng dẫn Testing

## Widget Tests

Để chạy tất cả các widget test:

```bash
flutter test
```

Để chạy một test cụ thể:

```bash
flutter test test/widget_test.dart
```

## Lưu ý quan trọng khi viết tests

1. Luôn sử dụng `tester.pumpAndSettle()` sau khi tải widget để đảm bảo tất cả animation đã hoàn tất và UI đã render xong.

2. Kiểm tra các dependency cần thiết đã được mock đúng cách trước khi chạy test.

3. Sử dụng `setupTestInjection()` để đảm bảo tất cả các dependency được cấu hình đúng cho test environment.

4. Kiểm tra hiển thị các widget quan trọng như `MaterialApp`, `HomePage`, v.v. để đảm bảo ứng dụng đã được khởi tạo thành công.

5. Sử dụng `TestAppWidget` để bao bọc các widget cần test với các bloc và dependency cần thiết.
## Viết tests hiệu quả

### Widget Testing

- Sử dụng `testWidgets` để test các widget
- Khi test các widget phức tạp, nên mock các dependencies
- Sử dụng `TestAppWidget` để tạo một môi trường app hoàn chỉnh

### Mocking

- Sử dụng `mockito` để tạo mock objects
- Thêm annotation `// ignore: must_be_immutable` cho các mock classes khi cần

### Best practices

- Mỗi test nên tập trung vào một chức năng cụ thể
- Mô tả rõ ràng mục đích của test trong chuỗi mô tả
- Sử dụng `expect` để kiểm tra kết quả
- Sử dụng `pumpAndSettle` để đợi animations hoàn thành

## Giải quyết các vấn đề thường gặp

### MissingPluginException

Khi test mà có sử dụng native plugins, bạn cần mock các plugin này:

### Tạo mocks cho BLoCs

Sử dụng `MockBloc` từ `bloc_test` để mock BLoCs:

```dart
class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState> implements ThemeBloc {}
```
