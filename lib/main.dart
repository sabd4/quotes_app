import 'package:flutter/material.dart';
import 'package:quotes_app/screens/qute_screen.dart';

//https://api.quotable.io/random ==>content author
//https://random.imagecdn.app/v1/image?category=buildings&format=json >> url
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quote App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: QuteImageScreen(),
    );
  }
}
