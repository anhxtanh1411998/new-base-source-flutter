import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String THEME_MODE = 'themeMode';

  ThemeBloc() : super(ThemeState.initial()) {
    on<ChangeThemeEvent>(_onChangeTheme);
    _loadSavedTheme();
  }

  void _onChangeTheme(ChangeThemeEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(THEME_MODE, event.themeMode.index);
    emit(state.copyWith(themeMode: event.themeMode));
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(THEME_MODE);

    if (themeModeIndex != null) {
      add(ChangeThemeEvent(ThemeMode.values[themeModeIndex]));
    }
  }
}
