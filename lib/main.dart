import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';
import 'package:shop_app/Pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Shopping App',
        theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.yellow,
              primary: Colors.yellow,
            ),
            inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(fontFamily: 'Lato', fontSize: 16),
                prefixIconColor: Colors.grey),
            textTheme: TextTheme(
              titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              bodyLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              bodySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        home: HomePage(),
      ),
    );
  }
}
