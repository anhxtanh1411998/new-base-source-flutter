import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:new_base_source_flutter/presentation/blocs/language/language.dart';
import 'package:new_base_source_flutter/presentation/blocs/theme/theme.dart';

// Tạo các mock class cho các dependency cần thiết
class MockSharedPreferences extends Mock implements SharedPreferences {}
// ignore: must_be_immutable
class MockThemeBloc extends Mock implements ThemeBloc {}
// ignore: must_be_immutable
class MockLanguageBloc extends Mock implements LanguageBloc {}
// ignore: must_be_immutable
class MockThemeState extends Mock implements ThemeState {}
// ignore: must_be_immutable
class MockLanguageState extends Mock implements LanguageState {}

// Khởi tạo GetIt cho testing
final GetIt slTest = GetIt.instance;

// Setup injection container cho test
Future<void> setupTestInjection() async {
  // Cấu hình SharedPreferences mock cho test
  SharedPreferences.setMockInitialValues({});

  // Reset GetIt instance nếu đã được đăng ký
  if (slTest.isRegistered<ThemeBloc>()) {
    await slTest.reset();
  }

  // Mock các blocs
  slTest.registerFactory<ThemeBloc>(() => MockThemeBloc());
  slTest.registerFactory<LanguageBloc>(() => MockLanguageBloc());

  // Setup mock behavior nếu cần thiết
  final themeBloc = slTest<ThemeBloc>();
  final languageBloc = slTest<LanguageBloc>();

  // Tạo các instance của State mà không sử dụng constructor trực tiếp
  final themeState = MockThemeState();
  final languageState = MockLanguageState();

  // Mock ThemeState
  when(themeBloc.state).thenReturn(themeState);
  when(themeState.themeMode).thenReturn(ThemeMode.light);

  // Mock LanguageState
  when(languageBloc.state).thenReturn(languageState);
  when(languageState.locale).thenReturn(const Locale('en'));
  when(LanguageBloc.getSupportedLocales()).thenReturn([const Locale('en'), const Locale('vi')]);
}
