import 'package:flutter/material.dart';

class CartScrren extends StatefulWidget {
  const CartScrren({super.key});

  @override
  State<CartScrren> createState() => _CartScrrenState();
}

class _CartScrrenState extends State<CartScrren> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Cart"),),
    );
  }
}