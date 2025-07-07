import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:new_base_source_flutter/presentation/blocs/language/language.dart';
import 'package:new_base_source_flutter/presentation/blocs/theme/theme.dart';

// Tạo các mock class cho các dependency cần thiết
class MockSharedPreferences extends Mock implements SharedPreferences {}
// ignore: must_be_immutable
class MockThemeBloc extends Mock implements ThemeBloc {
  final _stateController = StreamController<ThemeState>.broadcast();

  MockThemeBloc() {
    _stateController.add(const ThemeState(themeMode: ThemeMode.light));
  }

  @override
  ThemeState get state => const ThemeState(themeMode: ThemeMode.light);

  @override
  Stream<ThemeState> get stream => _stateController.stream;

  @override
  Future<void> close() {
    _stateController.close();
    return Future.value();
  }
}
// ignore: must_be_immutable
class MockLanguageBloc extends Mock implements LanguageBloc {
  final _stateController = StreamController<LanguageState>.broadcast();

  MockLanguageBloc() {
    _stateController.add(const LanguageState(locale: Locale('en')));
  }

  @override
  LanguageState get state => const LanguageState(locale: Locale('en'));

  @override
  Stream<LanguageState> get stream => _stateController.stream;

  @override
  Future<void> close() {
    _stateController.close();
    return Future.value();
  }

  static List<Locale> getSupportedLocales() {
    return [const Locale('en'), const Locale('vi')];
  }
}

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

  // Đăng ký các mock blocs
  slTest.registerFactory<ThemeBloc>(() => MockThemeBloc());
  slTest.registerFactory<LanguageBloc>(() => MockLanguageBloc());
}
