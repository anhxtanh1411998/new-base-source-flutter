import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:new_base_source_flutter/core/localization/app_localizations.dart';
import 'package:new_base_source_flutter/core/theme/app_theme.dart';
import 'package:new_base_source_flutter/presentation/blocs/language/language.dart';
import 'package:new_base_source_flutter/presentation/blocs/theme/theme.dart';

/// App widget đơn giản cho testing
class TestAppWidget extends StatelessWidget {
  final Widget child;
  final ThemeBloc themeBloc;
  final LanguageBloc languageBloc;

  const TestAppWidget({
    super.key,
    required this.child,
    required this.themeBloc,
    required this.languageBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>.value(value: themeBloc),
        BlocProvider<LanguageBloc>.value(value: languageBloc),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, languageState) {
              return MaterialApp(
                title: 'Test App',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeState.themeMode,
                locale: languageState.locale,
                supportedLocales: LanguageBloc.getSupportedLocales(),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                home: child,
              );
            },
          );
        },
      ),
    );
  }
}
