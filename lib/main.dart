import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskmanager/core/resources/app_theme.dart';
import 'package:taskmanager/firebase_options.dart';
import 'package:taskmanager/global/configuration.dart';
import 'package:taskmanager/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StartAppWidget(
      child: MaterialApp(
        title: 'Task Manager',
        theme: AppTheme.lightThemeMode,
        home: SplashScreen(),
      ),
    );
  }
}
