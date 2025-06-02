import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/localization/app_localizations.dart';
import '../blocs/language/language.dart';
import '../blocs/theme/theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('settings')),
      ),
      body: ListView(
        children: [
          // Theme settings
          ListTile(
            title: Text(AppLocalizations.of(context).translate('theme')),
            trailing: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return DropdownButton<ThemeMode>(
                  value: state.themeMode,
                  onChanged: (ThemeMode? newThemeMode) {
                    if (newThemeMode != null) {
                      context.read<ThemeBloc>().add(ChangeThemeEvent(newThemeMode));
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text(AppLocalizations.of(context).translate('system_mode')),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(AppLocalizations.of(context).translate('light_mode')),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(AppLocalizations.of(context).translate('dark_mode')),
                    ),
                  ],
                );
              },
            ),
          ),
          
          // Language settings
          ListTile(
            title: Text(AppLocalizations.of(context).translate('language')),
            trailing: BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, state) {
                return DropdownButton<String>(
                  value: state.locale.languageCode,
                  onChanged: (String? newLanguageCode) {
                    if (newLanguageCode != null) {
                      context.read<LanguageBloc>().add(
                        ChangeLanguageEvent(Locale(newLanguageCode)),
                      );
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text(AppLocalizations.of(context).translate('english')),
                    ),
                    DropdownMenuItem(
                      value: 'vi',
                      child: Text(AppLocalizations.of(context).translate('vietnamese')),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}