import 'package:flutter/material.dart';
import 'widgets/expenses.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var kColorScheme =
      ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 66, 141, 90));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondary,
          shadowColor: kColorScheme.inversePrimary,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.tertiary,
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontWeight: FontWeight.normal,
                //color: Colors.white,
              ),
            ),
      ),
      home: const Expenses(),
    );
  }
}
