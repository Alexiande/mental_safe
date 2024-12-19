import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _errorMessage = '';
  bool _isPasswordVisible = false;

  Future<void> _login() async {
    try {
      // Пытаемся войти с использованием email и пароля
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // После успешного входа переходим на следующий экран (например, на экран главной страницы)
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() {
        _errorMessage = 'Не удалось войти. Пожалуйста, проверьте свои данные.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFFDFFFD),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Картинка над текстом "С возвращением!"
            Image.asset(
              'assets/login_screen.png', // Укажите путь к вашему изображению
              height: screenHeight * 0.4, // Задаем высоту как 40% от высоты экрана
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            // Заголовок
            Text(
              'С возвращением!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A90E2), // Цвет заголовка
                fontFamily: 'Comfortaa', // Применяем шрифт
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Наше путешествие к благополучию начинается здесь',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF7F7F7F),
                fontFamily: 'Comfortaa', // Применяем шрифт
              ),
            ),
            SizedBox(height: 20),
            // Поля для ввода
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Почта',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Поле для пароля с возможностью скрытия/показа
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Пароль',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Забыли пароль?',
                style: TextStyle(
                  color: Color(0xFF4A90E2),
                  decoration: TextDecoration.underline,
                  fontFamily: 'Comfortaa', // Применяем шрифт
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text(
                'Начать',
                style: TextStyle(fontFamily: 'Comfortaa'), // Применяем шрифт
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Нет аккаунта? Зарегистрируйтесь',
                style: TextStyle(
                  color: Color(0xFF4A90E2),
                  fontFamily: 'Comfortaa', // Применяем шрифт
                ),
              ),
            ),
            SizedBox(height: 10),
            // Отображение сообщения об ошибке
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
