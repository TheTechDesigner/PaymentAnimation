import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'payment',
        child: Container(
          color: Color(0xFFC41A3B),
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Text(
                'Thank You!',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
