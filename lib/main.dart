import 'package:flutter/material.dart';
import 'package:responsi/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsi Praktikum TPM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.Red),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Color(0xff854f6c),
          titleTextStyle: TextStyle(
            color: Colors.deepGray,
            fontWeight: FontWeight.bold,
          ),
        ),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}
