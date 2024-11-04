import 'package:flutter/material.dart';

class SlideShowImage extends StatelessWidget {
  const SlideShowImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 600,
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(15)),
    );
  }
}