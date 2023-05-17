import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/quiz-logo.png', scale: 2),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Learn Flutter the fun way!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple),
                child: const Text(
                  'Start Quiz.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
