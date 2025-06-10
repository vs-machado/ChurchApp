import 'package:church_app/core/auth/presentation/auth_gate.dart';
import 'package:church_app/feature/posts/presentation/pages/post_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'feature/posts/presentation/models/post_ui.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const inputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.black, width: 2.0),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      labelStyle: TextStyle(color: Colors.black),
    );

    const textSelectionTheme = TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionHandleColor: Colors.black,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: inputDecorationTheme,
        textSelectionTheme: textSelectionTheme,
      ),
      localizationsDelegates: const [
        S.delegate,
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      home: const AuthGate(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/postDetails':
            final PostUi post = settings.arguments as PostUi;
            return MaterialPageRoute(
              builder: (context) => PostDetailsPage(post: post),
            );
          default:
            return null;
        }
      },
    );
  }
}
