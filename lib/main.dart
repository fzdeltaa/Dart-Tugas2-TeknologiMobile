import 'package:andro_teori_modul4/HomePage.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M4 Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Pastikan kamu memiliki LoginPage atau ganti dengan halaman awal yang kamu inginkan
      // home: Calculator(),
    );
  }
}
