import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:new_base_source_flutter/presentation/blocs/language/language_bloc.dart';
import 'package:new_base_source_flutter/presentation/blocs/theme/theme_bloc.dart';

// Tạo các mock class cho các dependency cần thiết
class MockSharedPreferences extends Mock implements SharedPreferences {}
class MockThemeBloc extends Mock implements ThemeBloc {}
class MockLanguageBloc extends Mock implements LanguageBloc {}

// Khởi tạo GetIt cho testing
final GetIt slTest = GetIt.instance;

// Setup injection container cho test
Future<void> setupTestInjection() async {
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

  // Mock ThemeState
  when(themeBloc.state).thenReturn(const ThemeState(themeMode: ThemeMode.light));

  // Mock LanguageState
  when(languageBloc.state).thenReturn(const LanguageState(locale: Locale('en')));
  when(LanguageBloc.getSupportedLocales()).thenReturn([const Locale('en'), const Locale('vi')]);
}
