import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_base_source_flutter/presentation/pages/home_page.dart';
import 'package:new_base_source_flutter/presentation/blocs/language/language.dart';
import 'package:new_base_source_flutter/presentation/blocs/theme/theme.dart';

import '../mocks/mock_dependencies.dart';
import '../test_app_widget.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Cài đặt mock dependencies cho test
  await setupTestInjection();

  testWidgets('HomePage renders successfully', (WidgetTester tester) async {
    // Lấy các mock bloc từ dependency injection
    final themeBloc = slTest<ThemeBloc>();
    final languageBloc = slTest<LanguageBloc>();

    // Build test app widget với HomePage
    await tester.pumpWidget(
      TestAppWidget(
        themeBloc: themeBloc,
        languageBloc: languageBloc,
        child: const HomePage(),
      ),
    );

    // Kiểm tra xem HomePage có render thành công không
    expect(find.byType(HomePage), findsOneWidget);
  });
}
