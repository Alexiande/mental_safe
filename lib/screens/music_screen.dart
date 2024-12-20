import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MeditationScreen extends StatefulWidget {
  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // Changed to AudioPlayer
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    SizedBox(height: 10),
                    _buildTitleSection(),
                    SizedBox(height: 30),
                    _buildMediaSection(context),
                    SizedBox(height: 30),
                    _buildPlayerControls(),
                    SizedBox(height: 100), // Add for BottomNav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_drop_down, size: 30, color: Color(0xFF6495ED)), // Cornflower Blue
            onPressed: () {
              print("Dropdown Tapped");
            },
          ),
          IconButton(
            icon: Icon(Icons.format_list_bulleted, size: 30, color: Color(0xFF6495ED)), // Cornflower Blue
            onPressed: () {
              print("Menu Tapped");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Время медитации',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6495ED), // Cornflower Blue
          ),
        ),
      ),
    );
  }

  Widget _buildMediaSection(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                "assets/images/meditation_bg.jpg",
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
            ),
            Positioned(
              child: GestureDetector(
                onTap: () async {
                  if (isPlaying) {
                    await _audioPlayer.stop();
                  } else {
                    await _audioPlayer.play(AssetSource('audio/meditation.mp3'));
                  }
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(40.0),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 45,
                    color: Color(0xFF6495ED), // Cornflower Blue
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildPlayerControls() {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Peace and Calm',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6495ED), // Cornflower Blue
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'By: Ijeoma Candy Obi',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.shuffle, size: 30, color: Color(0xFF6495ED)), // Cornflower Blue
              onPressed: () {
                print("Shuffle Tapped");
              },
            ),
            IconButton(
              icon: Icon(Icons.skip_previous, size: 30, color: Color(0xFF6495ED)), // Cornflower Blue
              onPressed: () {
                print("Prev Tapped");
              },
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[400]!, width: 1),
              ),
              child: IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 30,
                  color: Color(0xFF6495ED), // Cornflower Blue
                ),
                onPressed: () async {
                  if (isPlaying) {
                    await _audioPlayer.stop(); // Останавливаем музыку
                  } else {
                    await _audioPlayer.play(AssetSource('audio/meditation.mp3')); // Воспроизводим музыку
                  }

                  setState(() {
                    isPlaying = !isPlaying; // Переключаем состояние воспроизведения
                  });
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.skip_next, size: 30, color: Color(0xFF6495ED)), // Cornflower Blue
              onPressed: () {
                print("Next Tapped");
              },
            ),
            IconButton(
              icon: Icon(Icons.replay, size: 30, color: Color(0xFF6495ED)), // Cornflower Blue
              onPressed: () {
                print("Replay Tapped");
              },
            ),
          ],
        ),
      ],
    );
  }


  @override
  void dispose() {
    super.dispose();
  }
}

