import 'package:bun_app/screens/home_screen/widgets/product_grid.dart';
import 'package:bun_app/screens/home_screen/widgets/search_bar_wid.dart';
import 'package:bun_app/screens/home_screen/widgets/slide_show_image.dart';
import 'package:flutter/material.dart';

import 'widgets/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      "Hello, Migara",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg"),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SearchBarWid(),
              SizedBox(
                height: 20,
              ),
              SlideShowImage(),
              SizedBox(
                height: 10,
              ),
              Categories(),
              ProductGrid(),
            ],
          ),
        ),
      )),
    );
  }
}
