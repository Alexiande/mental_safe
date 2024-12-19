import 'package:flutter/material.dart';
import 'package:mental_safe/screens/login_screen.dart';
import 'package:mental_safe/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mental_safe/screens/welcome_screen.dart';
import 'package:mental_safe/screens/home_screen.dart';
import 'package:mental_safe/screens/registration_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/home' : (context) => HomeScreen(),
        'register': (context) => RegisterScreen(),
      },
    );
  }
}
