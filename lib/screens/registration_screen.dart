import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String _errorMessage = '';

  // Метод для проверки формата почты
  bool _isEmailValid(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  // Метод для проверки пароля
  bool _isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    return regex.hasMatch(password);
  }

  // Метод для сохранения данных в Firestore
  Future<void> _saveUserToFirestore(User user, String name, String email) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('Данные пользователя успешно сохранены в Firestore');
    } catch (e) {
      print('Ошибка сохранения данных в Firestore: $e');
      throw e; // Прокидываем ошибку
    }
  }

  Future<void> _register() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String name = _nameController.text.trim();

    if (name.isEmpty) {
      setState(() {
        _errorMessage = 'Введите имя.';
      });
      return;
    }

    if (!_isEmailValid(email)) {
      setState(() {
        _errorMessage = 'Неверный формат почты.';
      });
      return;
    }

    if (!_isPasswordValid(password)) {
      setState(() {
        _errorMessage = 'Пароль должен содержать буквы и цифры и быть не менее 6 символов.';
      });
      return;
    }

    try {
      // Регистрация пользователя
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        print('Регистрация прошла успешно: ${user.email}');

        // Сохраняем данные пользователя в Firestore
        await _saveUserToFirestore(user, name, email);

        // Переход на главный экран с передачей userId
        Navigator.pushReplacementNamed(context, '/calen', arguments: {'userId': user.uid});
      }
    } catch (e) {
      print('Ошибка регистрации: $e');
      setState(() {
        _errorMessage = 'Ошибка регистрации: ${e is FirebaseAuthException ? e.message : e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFFFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Изображение
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/welcome_image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Текст приветствия
              const Text(
                'Добро пожаловать!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Наше путешествие к благополучию\nначинается здесь',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),

              // Поле ввода имени
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Имя',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Поле ввода email
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Почта',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Поле ввода пароля
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Пароль',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Кнопка для регистрации
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6495ED),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Зарегистрироваться',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),

              // Сообщение об ошибке
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
