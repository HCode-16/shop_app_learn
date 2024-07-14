import 'package:flutter/material.dart';
import 'package:shop_app/Pages/cart_page.dart';
import 'package:shop_app/Widgets/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String selectedFilter;
  int currentPage = 0;

  List<Widget> pages = [ProductList(), CartPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentPage],
        bottomNavigationBar: BottomNavigationBar(
            iconSize: 35,
            currentIndex: currentPage,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            onTap: (value) {
              setState(() {
                currentPage = value;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: '')
            ]));
  }
}
