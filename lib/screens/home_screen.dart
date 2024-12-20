import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 20),
                    _buildGreeting(),
                    SizedBox(height: 20),
                    _buildMoodSelection(),
                    SizedBox(height: 30),
                    _buildArticlesSection(),
                    SizedBox(height: 100), // Adjusted spacing without Bottom Navigation
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.menu, size: 30),
          onPressed: () {
            print("Menu Tapped");
          },
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

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Добро пожаловать, Анна',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Как вы себя чувствуете сейчас?',
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildMoodSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMoodButton(
          icon: Icons.emoji_emotions,
          label: 'Happy',
          color: Colors.purple.shade100,
        ),
        _buildMoodButton(
          icon: Icons.brightness_1,
          label: 'Calm',
          color: Colors.blue.shade100,
        ),
        _buildMoodButton(
          icon: Icons.swap_calls,
          label: 'Relax',
          color: Colors.orange.shade100,
        ),
        _buildMoodButton(
          icon: Icons.accessibility_new_rounded,
          label: 'Focus',
          color: Colors.teal.shade100,
        ),
      ],
    );
  }

  Widget _buildMoodButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            size: 30,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildArticlesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Статьи экспертов',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        _buildArticleCard(
          title: 'Зачем посещать психолога?',
          author: 'Бредихина Ольга Николаевна',
          description:
          'Сомневаетесь, стоит ли идти к психологу? 5 неожиданных причин, почему это может стать вашим шагом к счастью!',
          image: 'assets/psychology.png',
          color: Colors.purple.shade50,
        ),
        SizedBox(height: 16),
        _buildArticleCard(
          title: 'Медитация - лучший помощник',
          author: 'Полещук Ирина Михайловна',
          description:
          'Откройте для себя, как медитация может стать вашим секретным оружием в борьбе со стрессом и тревогой!',
          image: 'assets/meditation.png',
          color: Colors.blue.shade50,
        ),
      ],
    );
  }

  Widget _buildArticleCard({
    required String title,
    required String author,
    required String description,
    required String image,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(author, style: TextStyle(fontSize: 14)),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 60,
            height: 60,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
