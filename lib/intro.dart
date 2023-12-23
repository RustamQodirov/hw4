import 'package:flutter/material.dart';
import 'package:lab_7/first_screen.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Federal qidiruv bo\'limi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/img1.png', 
              width: 150.0,
              height: 150.0, 
              fit: BoxFit.contain, 
            ),
            SizedBox(height: 20.0),
            
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 143, 111, 199),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FirstScreen()),
                );
              },
              child: Text('Tarmog\'ga ulanish'),
            ),
          ],
        ),
      ),
    );
  }
}
