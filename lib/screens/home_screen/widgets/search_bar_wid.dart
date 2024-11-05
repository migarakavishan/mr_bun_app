import 'package:flutter/material.dart';

class SearchBarWid extends StatelessWidget {
  const SearchBarWid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 600,
      decoration: BoxDecoration(
          color: const Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(20)),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Icon(Icons.search),
            Text(
              "Search for a product",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
