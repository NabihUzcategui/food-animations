import 'package:flutter/material.dart';
import 'package:flutter_food_animations/screens/menu_food.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: MenuFood.routeName,
      routes: {
        MenuFood.routeName: (context) => const MenuFood(),
      },
    );
  }
}
