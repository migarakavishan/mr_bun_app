import 'package:bun_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // List<ProductModel> products = DemoData.productList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF6F6F6),
        appBar: AppBar(
          backgroundColor: const Color(0xffF6F6F6),
          title: const Text("Favorite Items"),
        ),
        body: Consumer<AuthProvider>(builder: (context, value, child) {
          return value.favItems.isNotEmpty
              ? ListView.builder(
                  itemCount: value.favItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                              0,
                              0.6,
                              0.9,
                            ],
                            colors: [
                              Color(0xff352A4C),
                              Color(0xff534966),
                              Color(0xff7B748A),
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          value.favItems[index].image))),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value.favItems[index].title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "LKR ${value.favItems[index].price}0",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  value.removeFromFav(value.favItems[index]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                )),
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : const Center(child: Text("No Favorite Items Found"));
        }));
  }
}
