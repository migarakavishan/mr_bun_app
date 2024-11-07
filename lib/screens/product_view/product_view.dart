import 'package:bun_app/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: 400,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0,
                      0.6,
                      0.9,
                    ],
                    colors: [
                      Color(0xff352A4C),
                      Color(0xff534966),
                      Color(0xff7B748A),
                    ]),
              ),
            ),
          ),
        ),
        const Positioned(
          top: 50,
          child: Row(
            children: [
              BackButton(
                color: Colors.white,
              ),
              Text(
                "Product Details",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        Positioned(
          top: 180,
          left: 40,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.productModel.image))),
          ),
        ),
        Positioned(
            top: 450,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 400,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.productModel.title,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rs:${widget.productModel.price.toString()}0",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Text(
                          "Details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          widget.productModel.description,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Quantity",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 100,
                          height: 40,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xffB31312),
                                radius: 18,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "1",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              CircleAvatar(
                                backgroundColor: Color(0xffB31312),
                                radius: 18,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffB31312)),
                        onPressed: () {},
                        child: const Text(
                          "Add to Cart",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
            ))
      ],
    ));
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, size.height * -0.0025000);
    path.lineTo(0, size.height * 0.7125000);
    path.quadraticBezierTo(
      size.width * 0.2468750,
      size.height * 1.0025000,
      size.width * 0.5025000,
      size.height * 1.0075000,
    );
    path.quadraticBezierTo(
      size.width * 0.7518750,
      size.height * 0.9981250,
      size.width,
      size.height * 0.7150000,
    );
    path.lineTo(size.width, size.height * 0.0025000);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
