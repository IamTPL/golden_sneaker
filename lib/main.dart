import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const ShoeApp());
}

class ShoeApp extends StatelessWidget {
  const ShoeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Rubik',
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Color(0xFF303841)),
            bodyMedium: TextStyle(color: Color(0xFF303841)),
            bodySmall: TextStyle(color: Color(0xFF303841)),
          )),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
