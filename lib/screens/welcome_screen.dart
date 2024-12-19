import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Получаем размеры экрана
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFDFFFD),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Адаптивное изображение
                Image.asset(
                  'assets/boarding_screen.png',
                  height: screenHeight * 0.4, // Задаем высоту как 30% от высоты экрана
                  fit: BoxFit.contain, // Сохраняем пропорции изображения
                ),
                SizedBox(height: 20),
                // Разделяем текст на две строки с помощью Column
                Column(
                  children: [
                    Text(
                      'Добро пожаловать в',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6495ED),
                        fontFamily: 'Comfortaa', // Применяем шрифт
                      ),
                    ),
                    Text(
                      'MENTAL SAFE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6495ED),
                        fontFamily: 'Comfortaa', // Применяем шрифт
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Начните свой путь к стабильному внутреннему состоянию и эмоциональному благополучию. Наше приложение поможет вам в этом.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF7F7F7F),
                    fontFamily: 'Comfortaa', // Применяем шрифт
                  ),
                ),
              ],
            ),
          ),
          // Кнопка внизу справа
          Positioned(
            bottom: 47, // Отступ снизу
            right: 47, // Отступ справа
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Цвет кнопки
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Закругленные края
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Внутренние отступы
              ),
              child: Text(
                'Далее',
                style: TextStyle(
                  color: Color(0xFF6495ED), // Цвет текста
                  fontSize: 16,
                  fontFamily: 'Comfortaa', // Применяем шрифт
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
