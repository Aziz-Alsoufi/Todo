import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:Todo/layouts/home_layout.dart';
import 'package:Todo/core/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        // fontFamily: 'cairo',
        brightness: Brightness.dark,
      ),
      home: HomeScreen(),
    );
  }
}