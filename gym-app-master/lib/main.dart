import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_links/app_links.dart';

import 'providers/auth_provider.dart';
import 'screens/intro_screen.dart';
import 'screens/reset_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://tiyujmidcgzgjugeinpj.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRpeXVqbWlkY2d6Z2p1Z2VpbnBqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE0ODM5MDUsImV4cCI6MjA4NzA1OTkwNX0.BvcmaHvCD-Xts7Nw7Hk7WDF8U5cxiVo1Fm8A1ZJiEhk",
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _handleDeepLinks();
  }

  void _handleDeepLinks() {
    _appLinks.uriLinkStream.listen((Uri uri) {
      print("🔥 Deep link: $uri");

      if (uri.toString().contains("reset-password")) {
        navigatorKey.currentState?.pushNamed('/reset-password');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
      ),
      routes: {
        '/reset-password': (context) => const ResetPasswordPage(),
      },
      home: const IntroScreen(),
    );
  }
}