import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
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
          )
        ],
      ),
    );
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
