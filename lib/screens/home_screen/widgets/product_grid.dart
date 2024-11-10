import 'package:bun_app/providers/admin_provider.dart';
import 'package:bun_app/providers/auth_provider.dart';
import 'package:bun_app/screens/product_view/product_view.dart';
import 'package:bun_app/utils/custom_navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, child) {
        final products = adminProvider.allItems;

        if (products.isEmpty) {
          return const Center(child: Text("No products available"));
        }

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 0.80,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                CustomNavigators.goTo(
                  context,
                  ProductView(productModel: product),
                );
              },
              child: Hero(
                tag: product.id,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.6, 0.9],
                      colors: [
                        Color(0xff352A4C),
                        Color(0xff534966),
                        Color(0xff7B748A),
                      ],
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        product.image,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<AuthProvider>(
                        builder: (context, value, child) {
                      return Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                if (value.favID.contains(product.id)) {
                                  value.removeFromFav(product);
                                } else {
                                  value.addToFav(product);
                                }
                              },
                              child: Icon(
                                value.favID.contains(product.id)
                                    ? Icons.favorite
                                    : Icons.favorite_outline_rounded,
                                color: value.favID.contains(product.id)
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: IntrinsicHeight(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // Adjust height based on content
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Rs:${product.price}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
