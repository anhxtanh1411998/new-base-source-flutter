// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_base_source_flutter/presentation/blocs/language/language.dart';
import 'package:new_base_source_flutter/presentation/blocs/theme/theme.dart';

import 'mocks/mock_dependencies.dart';
import 'test_app_widget.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Cài đặt mock dependencies cho test
  await setupTestInjection();

  testWidgets('App renders successfully', (WidgetTester tester) async {
    // Lấy các mock bloc từ dependency injection
    final themeBloc = slTest<ThemeBloc>();
    final languageBloc = slTest<LanguageBloc>();

    // Build test app widget
    await tester.pumpWidget(
      TestAppWidget(
        themeBloc: themeBloc,
        languageBloc: languageBloc,
        child: const Scaffold(
          body: Center(
            child: Text('Hello Test'),
          ),
        ),
      ),
    );

    // Đợi cho animation hoàn tất
    await tester.pumpAndSettle();

    // Kiểm tra xem app có render thành công không
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Hello Test'), findsOneWidget);
  });
}
