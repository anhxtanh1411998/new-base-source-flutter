import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  static const String LANGUAGE_CODE = 'languageCode';

  LanguageBloc() : super(LanguageState.initial()) {
    on<ChangeLanguageEvent>(_onChangeLanguage);
    _loadSavedLanguage();
  }

  void _onChangeLanguage(ChangeLanguageEvent event, Emitter<LanguageState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(LANGUAGE_CODE, event.locale.languageCode);
    emit(state.copyWith(locale: event.locale));
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(LANGUAGE_CODE);
    
    if (languageCode != null) {
      add(ChangeLanguageEvent(Locale(languageCode)));
    }
  }

  // Helper method to get supported locales for the app
  static List<Locale> getSupportedLocales() {
    return const [
      Locale('en'), // English
      Locale('vi'), // Vietnamese
    ];
  }
}