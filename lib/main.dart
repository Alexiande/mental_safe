import 'package:flutter/material.dart';
import 'package:mental_safe/screens/login_screen.dart';
import 'package:mental_safe/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mental_safe/screens/welcome_screen.dart';
import 'package:mental_safe/screens/home_screen.dart';
import 'package:mental_safe/screens/registration_screen.dart';
import 'package:mental_safe/screens/calendar_screen.dart';
import 'package:mental_safe/screens/music_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Firebase для мобильных и веб платформ
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA619ZihCofPwJZmMt5DTicfr2lMpmU5LE",
      authDomain: "mental-b8fab.firebaseapp.com",
      projectId: "mental-b8fab",
      storageBucket: "mental-b8fab.appspot.com",
      messagingSenderId: "162689021856",
      appId: "1:162689021856:web:b8fab920bcab8d66fa1057",
      measurementId: "G-MK2TQ4HGH4",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/signup': (context) => RegisterScreen(),
        '/calen':(context) => CalendarScreen(),
      },
    );
  }
}
