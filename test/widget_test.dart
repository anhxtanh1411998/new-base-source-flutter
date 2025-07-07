// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_base_source_flutter/core/di/injection_container.dart' as di;

import 'package:new_base_source_flutter/main.dart';

void main() async {
  // Khởi tạo Flutter binding cho testing
  TestWidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo dependency injection
  await di.init();

  testWidgets('App renders successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Kiểm tra xem app có render thành công không
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
