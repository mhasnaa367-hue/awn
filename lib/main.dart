import 'package:awn/config/theme/theme.dart';
import 'package:awn/core/app_navigator.dart';
import 'package:awn/core/routesManager.dart';
import 'package:awn/core/API/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/widget/favorites_provider.dart';
import 'core/providers/user_provider.dart';
import 'core/language_provider.dart';
import 'l10n/app_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load any token saved from a previous session before the app starts.
  await TokenStorage.load();
  runApp(const Awn());
}

class Awn extends StatelessWidget {
  const Awn({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, langProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: appNavigatorKey,
            initialRoute: RoutesManager.Splashscreen,
            onGenerateRoute: RoutesManager.getRoute,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.themeMode,

            locale: langProvider.locale,
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}