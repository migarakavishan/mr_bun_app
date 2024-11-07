import 'package:bun_app/controllers/product_controller.dart';
import 'package:bun_app/model/product_model.dart';
import 'package:bun_app/screens/product_view/product_view.dart';
import 'package:bun_app/utils/custom_navigators.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, r});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProductController().fetchProducts(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Has Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade500,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            },
          );
        }

        List<ProductModel> product = snapshot.data!;

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: product.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 0.85,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                CustomNavigators.goTo(
                    context, ProductView(productModel: product[index]));
              },
              child: Container(
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
                  image: DecorationImage(
                    image: NetworkImage(product[index].image),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.topRight,
                        child:
                            Icon(Icons.favorite_outline, color: Colors.white),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product[index].title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Rs:${product[index].price}0",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
