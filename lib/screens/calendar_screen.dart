import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Для форматирования даты
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:mental_safe/screens/home_screen.dart';
import 'package:mental_safe/screens/profile_screen.dart';
import 'package:mental_safe/screens/music_screen.dart';
import 'package:mental_safe/screens/community_screen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String? _quote;
  String? _author;
  int _selectedIndex = 1;
  final String _apiKey = "cdfbe4bcbc4c5fba7a7d3a868e4cfaf9";
  final DateTime _today = DateTime.now(); // Текущая дата

  @override
  void initState() {
    super.initState();
    _fetchQuote();
  }

  Future<void> _fetchQuote() async {
    final url = Uri.parse('https://favqs.com/api/quote');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Token token=$_apiKey',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _quote = data['body'];
          _author = data['author'];
        });
      } else {
        print("Failed to load quote: ${response.statusCode}");
        setState(() {
          _quote = 'Ошибка загрузки цитаты.';
          _author = '';
        });
      }
    } catch (e) {
      print("Error fetching quote: $e");
      setState(() {
        _quote = 'Ошибка соединения.';
        _author = '';
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            HomeScreen(),
            _buildCalendarScreen(),
            CommunityScreen(),
            MeditationScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCalendarScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            SizedBox(height: 15),
            _buildDateHeader(),
            SizedBox(height: 15),
            _buildGreeting(),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _fetchQuote,
              child: _buildQuotePlaceholder(),
            ),
            SizedBox(height: 20),
            _buildWeeklyCalendar(),
            SizedBox(height: 30),
            _buildMoodSelection(),
            SizedBox(height: 30),
            _buildDailyGoals(),  // Adding the daily goals widget here
          ],
        ),
      ),
    );
  }

  Widget _buildDailyGoals() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Мои цели на день',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          _buildGoalCard(
              title: 'Медитация 5 минут',
              description: 'Цель: упорядочить мысли',
              image: "assets/meditation_goal.png"
          ),
          SizedBox(height: 10),
          _buildGoalCard(
              title: 'Посетить прием',
              description: 'Запись на 12:00',
              image: "assets/treatment_goal.png"
          )
        ],
      ),
    );
  }

  Widget _buildGoalCard({
    required String title,
    required String description,
    required String image,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purple.shade50,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(image),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ],
          ),
          Checkbox(value: false, onChanged: (bool? value) {}),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Календарь',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 40,
          height: 40,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(
            "assets/profile.png",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
  Widget _buildDateHeader() {
    final todayFormatted = DateFormat('EEEE, dd MMMM').format(_today); // Форматирование текущей даты

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todayFormatted.split(',')[0], // День недели
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          SizedBox(height: 5),
          Text(
            todayFormatted.split(',')[1].trim(), // Дата
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyCalendar() {
    final weekDays = List.generate(7, (index) => _today.add(Duration(days: index - _today.weekday + 1)));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekDays.map((day) {
          final isToday = day.day == _today.day;

          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isToday ? Colors.blueAccent : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  DateFormat('E').format(day), // День недели (например, Пн)
                  style: TextStyle(
                    fontSize: 14,
                    color: isToday ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  day.day.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isToday ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuotePlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _quote ?? 'Загрузка цитаты...',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            if (_author != null && _author!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  '- $_author',
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Дневники настроения',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMoodButton(Icons.emoji_emotions, 'Happy', Colors.purple.shade100),
              _buildMoodButton(Icons.brightness_1, 'Calm', Colors.blue.shade100),
              _buildMoodButton(Icons.swap_calls, 'Relax', Colors.orange.shade100),
              _buildMoodButton(Icons.accessibility_new_rounded, 'Focus', Colors.teal.shade100),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return FutureBuilder<String>(
      future: _fetchUserName(), // Функция для получения имени пользователя
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Загрузка...',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Привет!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Привет, ${snapshot.data}!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
      },
    );
  }

  Future<String> _fetchUserName() async {
    try {
      // Получение ID текущего пользователя
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      if (userId.isEmpty) {
        throw Exception('Пользователь не авторизован.');
      }

      // Получение документа пользователя из Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users') // Убедитесь, что коллекция называется 'users'
          .doc(userId)
          .get();

      // Извлечение имени пользователя
      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        return data['name'] ?? 'Пользователь';
      } else {
        return 'Пользователь';
      }
    } catch (e) {
      print('Ошибка получения имени пользователя: $e');
      return 'Гость';
    }
  }

  Widget _buildMoodButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, size: 30, color: Colors.grey[800]),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
