import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/auth_provider.dart';
import 'screens/home_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/reset_password_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://tiyujmidcgzgjugeinpj.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRpeXVqbWlkY2d6Z2p1Z2VpbnBqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE0ODM5MDUsImV4cCI6MjA4NzA1OTkwNX0.BvcmaHvCD-Xts7Nw7Hk7WDF8U5cxiVo1Fm8A1ZJiEhk",
  );

  final authProvider = AuthProvider();
  await authProvider.initialize();

  runApp(
    ChangeNotifierProvider.value(
      value: authProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        fontFamily: 'Poppins',
        brightness: Brightness.dark,
      ),
      routes: {
        '/reset-password': (context) => const ResetPasswordScreen(),
      },
      home: auth.isAuthenticated ? const HomeScreen() : const IntroScreen(),
    );
  }
}
