import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Таймер для перехода через 5 секунд
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    // Получаем размеры экрана
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Фоновое изображение
          Image.asset(
            'assets/splash_screen.png', // Укажите путь к вашему изображению
            fit: BoxFit.cover,
          ),
          // Текст поверх фона
          Center(
            child: Text(
              'MENTAL SAFE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Comfortaa', // Указываем шрифт
                color: Color(0xFF538279),
                fontSize: screenSize.width * 0.08, // Размер текста зависит от ширины экрана
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
