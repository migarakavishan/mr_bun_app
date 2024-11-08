import 'package:bun_app/providers/auth_provider.dart';
import 'package:bun_app/screens/home_screen/widgets/product_grid.dart';
import 'package:bun_app/screens/home_screen/widgets/search_bar_wid.dart';
import 'package:bun_app/screens/home_screen/widgets/slide_show_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _refreshData() async {
    await Provider.of<AuthProvider>(context, listen: false).refreshUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          "Hello, ${Provider.of<AuthProvider>(context).userModel?.name}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          Provider.of<AuthProvider>(context).userModel!.image 
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SearchBarWid(),
                  const SizedBox(
                    height: 20,
                  ),
                  const SlideShowImage(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Categories(),
                  const SizedBox(
                    height: 20,
                  ),
                  const ProductGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
