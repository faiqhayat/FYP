import 'package:flutter/foundation.dart' show kIsWeb;
import 'platform.dart'; // your isWindows stub
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/heatmap_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/status_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // only initialize the real Firebase on mobile/desktop (not on Windows) and not on Web
  if (!isWindows && !kIsWeb) {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print("Firebase init failed (skipped): $e");
    }
  }

  runApp(const WiViApp());
}

class WiViApp extends StatefulWidget {
  const WiViApp({super.key});

  @override
  _WiViAppState createState() => _WiViAppState();
}

class _WiViAppState extends State<WiViApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/heatmaps': (context) => const HeatmapScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/status': (context) => const StatusScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/dashboard') {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (_) =>
                DashboardScreen(userName: args?['userName'] ?? "User"),
          );
        }
        return null;
      },
    );
  }
}
