import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      debugShowCheckedModeBanner: false,
      home: const StopwatchHome(),
    );
  }
}

class StopwatchHome extends StatefulWidget {
  const StopwatchHome({super.key});

  @override
  State<StopwatchHome> createState() => _StopwatchHomeState();
}

class _StopwatchHomeState extends State<StopwatchHome> {
  int _milliseconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    if (_isRunning) return;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _milliseconds += 10;
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int milliseconds) {
    int minutes = (milliseconds ~/ 60000);
    int seconds = (milliseconds ~/ 1000) % 60;
    int ms = (milliseconds % 1000) ~/ 10;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}:'
        '${ms.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'StopWatch',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatTime(_milliseconds),
            style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
              color: _isRunning ? Colors.blue : Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: ElevatedButton(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: _isRunning ? Colors.orange : Colors.green,
                    padding: EdgeInsets.zero,
                    fixedSize: const Size(70, 70),
                  ),
                  child: Icon(
                    _isRunning ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),

              SizedBox(
                width: 70,
                height: 70,
                child: ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.zero,
                    fixedSize: const Size(70, 70),
                  ),
                  child: const Icon(
                    Icons.replay,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
