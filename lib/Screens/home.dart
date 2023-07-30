import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testassignment/Screens/Theme/theme.dart';
import 'package:testassignment/Screens/widget/productgrid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Test_Assignment",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Icon(
              CupertinoIcons.cart,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: shadowdecoration,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                controller: search,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "All Products",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            const ProductGrid()
          ],
        ),
      ),
    );
  }
}